/*
Projeto desenvolvido por Lucas Camps Achcar
Do it yourself (DIY)
Código receptor de IR
Protocolo baseado em NEC Protocol
https://www.sbprojects.net/knowledge/ir/nec.php
*/
#define DEBUG_MODE false
enum STATUS { LEAD_CODE_HIGH, LEAD_CODE_LOW, RECEIVE_CODE, BIT_RECEIVE };

#define LEAD_CODE_CYCLE_TIME_HIGH 9 - 9 / 3
#define LEAD_CODE_CYCLE_TIME_LOW 4.5 - 4.5 / 3
#define RECEIVE_CODE_CYCLE_TIME 0.56 - 0.56 / 3
#define BIT_1_CYCLE_TIME 1.12 - 1.12 / 3
#define BIT_0_CYCLE_TIME 0.56 - 0.56 / 3

#define AMOUNT_BYTE 32

class IRController {
  protected:
    unsigned PIN_INPUT;

    double nextReadTime;
    double lastTime;
    double currentTime;
  
    double initialRegisterLOW;
    double lastRegisterLOW;
  
  double initialRegisterHIGH;
    double lastRegisterHIGH;
  
    bool lastRead;

    double freqPulse;

    STATUS stats;
  
    unsigned indexBuffer;
    bool buffer[AMOUNT_BYTE];
    int hex;
  
  public:
    IRController(unsigned, double);
    void resetController();
    void readSignal();
    double convertMillisToMicros(double Millis);
    long unsigned getCode();
    void clearBuffer();
};

// Convert buffer to hex
long unsigned IRController::getCode() {
  long unsigned retn = 0;
  if(stats == LEAD_CODE_HIGH) {
    for(unsigned i = 8; i < AMOUNT_BYTE; ++i) {
      retn = retn << 1;
      retn |= buffer[i];
    }
  }
  return retn;
}

void IRController::clearBuffer() {
  if(stats == LEAD_CODE_HIGH) {
    for(unsigned i = 0; i < AMOUNT_BYTE; ++i)
      buffer[i] = 0;
  }
}

IRController::IRController(unsigned PIN_INPUT, double freqPulse) {
  this->PIN_INPUT = PIN_INPUT;
  this->freqPulse = freqPulse;
  
  pinMode(PIN_INPUT, INPUT);
  
  resetController();
}

void IRController::resetController() {
  /* 10^6 microSecond -> 1 second */
  nextReadTime = (1.0f / freqPulse)*pow(10, 6);
  
  stats = LEAD_CODE_HIGH;
  
  indexBuffer = 0;
}

void IRController::readSignal() {
  currentTime = micros();
  if((currentTime - lastTime) > nextReadTime) {
    
    bool valueRead = !digitalRead(PIN_INPUT);
   
    // Register de LOW and HIGH last and current time to checking
    if(valueRead == HIGH) {
      lastRegisterHIGH = currentTime;
      
      if(lastRead != valueRead) {
        initialRegisterHIGH = currentTime;
        lastRegisterLOW = currentTime;
      }
    } else  {
      lastRegisterLOW = currentTime;
      
      if(lastRead != valueRead) {
        initialRegisterLOW = currentTime;
        lastRegisterHIGH = currentTime;
      }
    }
    
    double RegisterHigh = lastRegisterHIGH - initialRegisterHIGH;
    double RegisterLow = lastRegisterLOW - initialRegisterLOW;
    
    if(lastRead != valueRead) {
      // Lead Code
      if((RegisterLow) >= convertMillisToMicros(LEAD_CODE_CYCLE_TIME_LOW) && stats == LEAD_CODE_LOW) {
        // Waiting Pulse Low Finish to Register Bit
        stats = RECEIVE_CODE;
      } else if((RegisterHigh) >= convertMillisToMicros(LEAD_CODE_CYCLE_TIME_HIGH) && stats == LEAD_CODE_HIGH){
        // Waiting Next Pulse Low (LEAD_CODE)
        stats = LEAD_CODE_LOW;
      } else if(stats == RECEIVE_CODE && (RegisterHigh) >= convertMillisToMicros(RECEIVE_CODE_CYCLE_TIME)) {
        stats = BIT_RECEIVE;
      } else if(stats == BIT_RECEIVE) {
        // Receive Code
        if((RegisterLow) >= convertMillisToMicros(BIT_1_CYCLE_TIME)) {
          // Bit 1
          buffer[indexBuffer++] = 1;
          stats = RECEIVE_CODE;
        } else if((RegisterLow) >= convertMillisToMicros(BIT_0_CYCLE_TIME)) {
          // Bit 0
          buffer[indexBuffer++] = 0;
          stats = RECEIVE_CODE;
        }
      }
      
      // Test -> Print Buffer and Reset IRRemote
      if(indexBuffer == AMOUNT_BYTE) {
        if(DEBUG_MODE) {
          for(unsigned i = 0; i < AMOUNT_BYTE; i++)
            Serial.print(buffer[i]);
          Serial.println();
          Serial.print("HEX ");
          Serial.print(getCode(), HEX);
          Serial.println();
        }
        resetController();
      }
    }
    
    lastTime = micros();
    
    // Change the last value read
    lastRead = valueRead;
  }
}

double IRController::convertMillisToMicros(double Millis) {
  return Millis*pow(10, 3);
}

IRController *IR;

/* Test */

unsigned LED[] = {8, 9, 10};
bool LEDstats[] = {false, false, false};

void setup() {
  Serial.begin(9600);
  
  pinMode(LED[0], OUTPUT);
  pinMode(LED[1], OUTPUT);
  pinMode(LED[2], OUTPUT);
  
  // Port 03 and freqPulse 37.917Khz
  IR = new IRController(3, 37.917*pow(10, 3));
  Serial.println("IRRemote Controller");
}

void loop() {
  IR->readSignal();
  
  unsigned long codeValue = IR->getCode();
  if(codeValue) {
    IR->clearBuffer();
    
    Serial.print("HEX ");
    Serial.print(codeValue, HEX);
    Serial.println();
    
    /* Test */
    if(codeValue == 0x7B807F) {
      LEDstats[0] = !LEDstats[0];
      digitalWrite(LED[0], LEDstats[0] ? HIGH : LOW);
    } else if(codeValue == 0x7BC03F) {
      LEDstats[1] = !LEDstats[1];
      digitalWrite(LED[1], LEDstats[1] ? HIGH : LOW);
    } else if(codeValue == 0x7BA05F) {
      LEDstats[2] = !LEDstats[2];
      digitalWrite(LED[2], LEDstats[2] ? HIGH : LOW);
    }
  }
}

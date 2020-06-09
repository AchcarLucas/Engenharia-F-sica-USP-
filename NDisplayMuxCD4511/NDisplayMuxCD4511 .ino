/*
	Código Desenvolvido por Lucas Campos Achcar 09/06/2020.
	Trabalho Projeto para Apresentação na aula de Introdução a eletrônica e computação física. 
*/
#define SERIAL_RUNNING false
class MUX {
  	#define OUTPUT_PORT 3
	private:
  		unsigned E[3];
  		unsigned char N_MUX;
  		unsigned char MUX_COUNTER;
  	public:
  		MUX(unsigned E0, unsigned E1, unsigned E2, unsigned char N_MUX);
  		void upper();
  		void lower();
  		void change();
  		void reset();
  		unsigned char getMuxCounter();
  		unsigned char getNumMux();
};

MUX::MUX(unsigned E0, unsigned E1, unsigned E2, unsigned char N_MUX) {
  this->E[0] = E0;
  this->E[1] = E1;
  this->E[2] = E2;
  
  // Amount of MUX to reset
  this->N_MUX = N_MUX;
  
  // MUX Counter
  this->MUX_COUNTER = 0;
  
  for(unsigned i = 0; i < OUTPUT_PORT; ++i)
  	pinMode(this->E[i], OUTPUT);
}

// Direct Counter
void MUX::upper() {
  MUX_COUNTER++;
  MUX_COUNTER = MUX_COUNTER % (N_MUX + 1);
}

// Revert Counter
void MUX::lower() {
  MUX_COUNTER = (MUX_COUNTER <= 0) ? N_MUX : MUX_COUNTER - 1;
  
}

void MUX::change() {
  /*
  	 E0 (upper bit)  E1 (middle bit)  E2 (lower bit)
     B(B1)(B2)(B3)
  */
  
  if(SERIAL_RUNNING) {
  	Serial.println("E(DEC) " + String(MUX_COUNTER, DEC) + " N_MUX " + String(N_MUX, BIN));
  	Serial.println("BIN(");
  }
  
  /*for(unsigned i = 0; i < OUTPUT_PORT; ++i) {
    unsigned p = (i + 1)*(i + 1);
    bool c = MUX_COUNTER & p;
  	digitalWrite(E[i], c);
    Serial.println(String(p) + ",");
  } Tinkercad POW doesn't work */
  
  bool c = MUX_COUNTER & 0x04;
  digitalWrite(E[0], c);
  if(SERIAL_RUNNING)
  	Serial.println(String(c) + ",");
  
  c = MUX_COUNTER & 0x02;
  digitalWrite(E[1], c);
  
  if(SERIAL_RUNNING)
  	Serial.println(String(c) + ",");
  
  c = MUX_COUNTER & 0x01;
  digitalWrite(E[2], c);
  
  if(SERIAL_RUNNING) {
  	Serial.println(String(c) + ",");
  	Serial.println("}");
  }
}

void MUX::reset() {
  MUX_COUNTER = 0;
  change();
}

unsigned char MUX::getMuxCounter() {
  return this->MUX_COUNTER;
}

unsigned char MUX::getNumMux() {
  return this->N_MUX;
}

///////////////////////////////
///////////////////////////////

class NDisplayMuxCD4511 {
  	private:
		MUX *mux;
  		unsigned A0, A1, A2, A3;
  		long unsigned int valueDisplay;
  		unsigned int delayUpdate;
  public:
  		NDisplayMuxCD4511(MUX *, unsigned, unsigned, unsigned, unsigned, unsigned);
		void setDisplayValue(long unsigned int);
  		long unsigned getDisplayValue();
  		void resetDisplay();
  		void display();
};

NDisplayMuxCD4511::NDisplayMuxCD4511(MUX *mux, unsigned A0, unsigned A1, unsigned A2, unsigned A3, unsigned delayUpdate) {
  this->mux = mux;
  
  this->A0 = A0;
  this->A1 = A1;
  this->A2 = A2;
  this->A3 = A3;
  
  this->delayUpdate = delayUpdate;
  
  pinMode(A0, OUTPUT);
  pinMode(A1, OUTPUT);
  pinMode(A2, OUTPUT);
  pinMode(A3, OUTPUT);
  
  this->valueDisplay = 0;
}

void NDisplayMuxCD4511::setDisplayValue(long unsigned valueDisplay) {
  this->valueDisplay = valueDisplay;
}

long unsigned NDisplayMuxCD4511::getDisplayValue() {
  return this->valueDisplay;
}

void NDisplayMuxCD4511::resetDisplay() {
  this->valueDisplay = 0;
  mux->reset();
}

void NDisplayMuxCD4511::display() {
  long unsigned copyValueDisplay = valueDisplay;
  
  if(SERIAL_RUNNING) {
  	Serial.print("valueDisplay ");
  	Serial.println(copyValueDisplay);
  }
  
  mux->reset();
  mux->lower();
  
  for(unsigned i = 0; i <= mux->getNumMux(); ++i) {
  	short digit = (copyValueDisplay % 10);
  	copyValueDisplay = copyValueDisplay / 10;
    
    if(SERIAL_RUNNING)
    	Serial.println("Digit " + String(digit));
    
    bool c = digit & 0x01;
    digitalWrite(A0, c);
    
    c = digit & 0x02;
    digitalWrite(A1, c);
    
    c = digit & 0x04;
    digitalWrite(A2, c);
    
    c = digit & 0x08;
    digitalWrite(A3, c);
    
    mux->change();
    
    // Waiting time to next mux
    delay(delayUpdate);
    
    // Mux again
    mux->lower();
  }
}

///////////////////////////////
///////////////////////////////

NDisplayMuxCD4511 *display;

#define MODO 2

void setup() {
  Serial.begin(9600);
  display = new NDisplayMuxCD4511(new MUX(2, 3, 4, 0x07), 5, 6, 7, 8, 15);
  display->setDisplayValue(12345678);
  // TEST
  if(MODO == 0 || MODO == 1)
  	display->setDisplayValue(0);
}

void loop() {
  static unsigned long currentTime = 0;
  currentTime += millis();
  static unsigned long lastTime = currentTime;
  
  // TEST
  if(MODO == 0) {
    // Waiting a time to increase
    if((currentTime - lastTime) > 10) {
      display->setDisplayValue(display->getDisplayValue() + 1);
      lastTime = currentTime;
    }
  } else if(MODO == 1) {
    if((currentTime - lastTime) > 50) {
  		display->setDisplayValue(10);
    }
  }
  
  display->display();
  delay(1);
}

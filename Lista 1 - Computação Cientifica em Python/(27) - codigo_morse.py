"""
    Morse Dictionaries
"""
morse = {'A': ".-",
       'B': "-...",
       'C':"-.-.",
       'D':"-..",
       'E':".",
       'F':"..-.",
       'G':"--.",
       'H':"....",
       'I':"..",
       'J':".---",
       'K':"-.-",
       'L':".-..",
       'M':"--",
       'N':"-.",
       'O':"---",
       'P':".--.",
       'Q':"--.-",
       'R':".-.",
       'S':"...",
       'T':"-",
       'U':"..-",
       'V':"...-",
       'W':".--",
       'X':"-..-",
       'Y':"-.--",
       'Z':"--..",
       '0':"-----",
       '1':".----",
       '2':"..---",
       '3':"...--",
       '4':"....-",
       '5':".....",
       '6':"-....",
       '7':"--...",
       '8':"---..",
       '9':"----."}

#t_msg = input('Digite uma mensagem: ').upper()

t_msg = "Hello World!".upper()

upperLetter = [i for i in range(ord('A'), ord('Z'))]
upperNumber = [i for i in range(ord('0'), ord('9'))]

msg = ''

for i in t_msg:
    if ord(i) in upperLetter + upperNumber:
        msg += i

print(f'msg = {msg}')

convert = ''

for v in msg:
    convert += morse[v] + " "
print(convert)

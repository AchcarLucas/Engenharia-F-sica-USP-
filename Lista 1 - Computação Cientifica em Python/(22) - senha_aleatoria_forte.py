import numpy.random


upper_letter = [chr(n) for n in range(65, 90)]
lower_letter = [chr(n) for n in range(97, 122)]
number = [chr(n) for n in range(48, 57)]

def check_password(s):
    c_upper_letter = [v for v in s if v in upper_letter]
    c_lower_letter = [v for v in s if v in lower_letter]
    c_number = [v for v in s if v in number]
    if(len(s) >= 8 and len(c_upper_letter) > 0 and len(c_lower_letter) > 0 and len(c_number) > 0):
        return True
    return False
    
password = ''
attempt = 0

while not check_password(password):
    password = ''
    for n in range(0, numpy.random.randint(7, 10)):
        password += chr(numpy.random.randint(33, 126))
    attempt += 1

check_password(password)

print(f'Attempt {attempt}')
print(f'Password: {password}')

# Lucas Campos Achcar

def CesarCodeMessage(msg, offset):
    msg_crpt = []
    
    for v in msg:
        # Criptografia dos Caracteres Maiúsculos
        if 65 <= ord(v) <= 90:
            '''
                Pega o valor em inteiro do caracter, diminui 65 (Se o caracter
                for A, teremos 0 como inteiro. Se o valor passar de 26 (26 caracteres no total)
                o valor volta para a contagem 0, após essa verificação, adiciomanos + 65 para converter
                para caracter.
            '''
            msg_crpt += chr(((ord(v) - 65 + offset) % 26) + 65)
        # Criptografia dos Caracteres Minúsculo
        elif 97 <= ord(v) <= 122:
            '''
                Pega o valor em inteiro do caracter, diminui 65 (Se o caracter
                for A, teremos 0 como inteiro. Se o valor passar de 26 (26 caracteres no total)
                o valor volta para a contagem 0, após essa verificação, adiciomanos + 65 para converter
                para caracter.
            '''
            msg_crpt += chr(((ord(v) - 97 + offset) % 26) + 97)
        # Resto da string que não são criptografados
        else:
            msg_crpt += v

    # Converte List para String e retorna a mensagem codificada ou decodificada
    return ''.join(msg_crpt)

def _main():
    msg = input('Mensagem: ')
    offset = int(input('Fator (Codificação/Decodificação): '))

    print(f'Você irá codificar/decodificar a mensagem [{msg}] com um offset de [{offset}]')
    print(f'Mensagem (Codificada/Decodificada): {CesarCodeMessage(msg, offset)}')

_main()

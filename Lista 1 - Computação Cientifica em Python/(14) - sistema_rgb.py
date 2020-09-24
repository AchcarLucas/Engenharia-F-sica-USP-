# Lucas Campos Achcar

# Dicionários de conversões
DecHex = {0:'0', 1:'1', 2:'2', 3:'3', 4:'4', 5:'5', 6:'6', 7:'7', 8:'8', 9:'9', 10:'A', 11:'B', 12:'C', 13:'D', 14:'E', 15:'F'}
HexDec = {'0':0, '1':1, '2':2, '3':3, '4':4, '5':5, '6':6, '7':7, '8':8, '9':9, 'A':10, 'B':11, 'C':12, 'D':13, 'E':14, 'F':15}

# Recebe uma string contendo a base Hexadecimal e converte para a Base 10
def convertHexToDec(s_hex):
    # Variável auxiliar da conversão (irá armazenar o valor final)
    c_dec = 0
    
    # Inverte a string hex, pois o último valor é o de menor expoente
    s_hex = s_hex[::-1]
    
    for n in range(0, len(s_hex)):
        '''
            Converte os A, B, C, D, E, F para (10, 11, 12, 13, 14, 15) e converte
            para decimal respeitando a base (posição) em que se encontra
        '''
        c_dec += int(HexDec[s_hex[n]])*pow(16, n)

    # Retorna o valor inteiro (base 10) da conversão
    return c_dec

# Recebe um valor inteiro (Base 10) e converte para a base Hexadecimal
def convertDecToHex(v_dec):
    c_hex = ['0'] * 6

    c_idx_hex = 0

    # Faz todo o processo até o valor ser diferente de 0
    while v_dec != 0:
        # Pega o resto da divisão por 16 e adiciona em c_hex
        c_r = v_dec % 16
        c_hex[c_idx_hex] = DecHex[c_r]
        # Pega apenas a parte inteira da divisão e continua o processo
        v_dec = v_dec // 16
        c_idx_hex += 1

    # Inverte a lista e converte em string (corresponde ao valor Hex)
    return ''.join(c_hex[::-1])

def _main():
    # Cor em Hex para Dec
    HexToDec = 'CD1F41'


    print("------------------------------------")
    print("Convertendo Hexadecimal para Decimal")
    print("------------------------------------")
    
    t_c_cor = convertHexToDec(HexToDec)
    print(f'Valor em Hexadecimal {HexToDec}\nValor em Decimal {t_c_cor}')

    '''
        Faz o movimento de 16 bits (shift right)
        Exemplo, se temos a seguinte sequência 11001101 11111111 11101111,
        deslocamos 16 bits para a direita ficando com 00000000 00000000 11001101,
        ai aplicamos um and de 0xFF para pegar apenas aquela parte (11001101),
        se faz isso deslocando 8 bits e 0 bits respectivamente para termos R G e B
    '''
    
    r = (t_c_cor >> 16) & 0xFF
    g = (t_c_cor >> 8) & 0xFF
    b = (t_c_cor >> 0) & 0xFF
    
    print(f'Vermelho (R): {r}\nVerde (G): {g}\nAzul (B): {b}')

    print("------------------------------------")
    print("Convertendo Decimal para Hexadecimal")
    print("------------------------------------")

    t_h_cor = convertDecToHex(t_c_cor)
    print(f'Valor em Decimal {t_c_cor}\nValor em Hexadecimal {t_h_cor}')

    '''
        Pega na string Hex os valores correspondente a R, G e B
    '''

    r = t_h_cor[len(t_h_cor) - 6:len(t_h_cor) - 4]
    g = t_h_cor[len(t_h_cor) - 4:len(t_h_cor) - 2]
    b = t_h_cor[len(t_h_cor) - 2:len(t_h_cor)]

    print(f'Vermelho (R): {r}\nVerde (G): {g}\nAzul (B): {b}')

_main()
    

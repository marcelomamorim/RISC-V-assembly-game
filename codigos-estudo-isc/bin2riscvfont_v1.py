def strBinToDec(num):
    tam = len(num)
    ans = 0
    
    num = num[::-1]
    for i in range(tam):
        ans += int(num[i]) * 2**i
    
    return ans
    
def inverte(a):
    ans = ''
    
    for i in range(4):
        ans = str(a[8*i:8*(i+1)]) + ans
    
    return ''.join(ans)

def converte(num):
    a = num[:32]
    b = num[32:]
    
    a = inverte(a)
    b = inverte(b)
    
    return (str(hex(strBinToDec(a))), str(hex(strBinToDec(b))))

def formataHex(num): # mas recebe hex como string...
    return '0x'+'0'*(8-len(num[2:]))+num[2:].upper()

print('Digite a representação linear em 8x8 da letra em questão (sequência de 64 bits), um por cada linha\n')

while True:
    try:
        num = input()
        num += '0' * (64 - len(num))
        
        ans = converte(num)
        
        print("{}, {}, ".format(formataHex(ans[0]), formataHex(ans[1])))
        print(formataHex(ans[0]))
        print(formataHex(ans[1]))
        print()
    except:
        break
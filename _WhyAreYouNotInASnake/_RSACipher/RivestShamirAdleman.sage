alphabet = ["!", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"];

N = int(input("N = "))
E = int(input("E = "))
D = [int(x) for x in input("[D] = ").split(" ")]

def GetPhiN(N):
    Factors = factor(N);
    p1 = Factors[0][0];
    p2 = Factors[1][0];
    print("P1 = " + str(p1) + "; P2 = " + str(p2))
    phiN = ((p1 - 1) * (p2 - 1)) / gcd(p1 - 1, p2 - 1);
    print("Phi(N) = " + str(phiN))
    return phiN

def GetPrivateComponent(phiN, publicComponent):
    i = 0
    print(">—————————————<Iteration #0>—————————————<")
    A = phiN;
    B = publicComponent;
    Q = floor(A/B);
    R = A % B;
    T1 = 0;
    T2 = 1;
    T3 = T1 - (T2 * Q);
    print("A = " + str(A))
    print("B = " + str(B))
    print("Q = " + str(Q))
    print("R = " + str(R))
    print("T1 = " + str(T1))
    print("T2 = " + str(T2))
    print("T3 = " + str(T3))
    while R != 0:
        i += 1;
        print(">—————————————<Iteration #" + str(i) + ">—————————————<")
        A = B;
        B = R;
        Q = floor(A/B);
        R = A % B;
        T1 = T2;
        T2 = T3;
        T3 = T1 - (T2 * Q);
        print("A = " + str(A))
        print("B = " + str(B))
        print("Q = " + str(Q))
        print("R = " + str(R))
        print("T1 = " + str(T1))
        print("T2 = " + str(T2))
        print("T3 = " + str(T3))
    privateComponent = T2 % phiN;
    if (privateComponent*publicComponent)%phiN == 1:
        return privateComponent;
    else:
        print("Error: Cannot get private component of RSA keypair");
        return;
    return;

def Decrypt(N, publicComponent, D):
    phiN = GetPhiN(N);
    word = ""
    privateComponent = GetPrivateComponent(phiN, publicComponent);
    for encryptedNumber in D:
        decryptedNumber = ((encryptedNumber ** privateComponent) % N) - 1;
        word += alphabet[decryptedNumber]
    print("Decrypted Word: " + word)
    return;

Decrypt(N, E, D)
"""
6) A simple cipher built on the alphabet wheel [A-Z] (uppercase).
   Given encrypted string of only A-Z, decrypt by shifting k steps
   COUNTERCLOCKWISE (i.e. go backward k) around the wheel.

Example:
 encrypted = 'VTAOG'
 k=2
 => 'TRYME'
"""

def simpleCipher(encrypted, k):
    alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    decrypted = []
    for ch in encrypted:
        old_index = alphabet.index(ch)
        new_index = (old_index - k) % 26  #modulo
        decrypted.append(alphabet[new_index])
    return "".join(decrypted)

if __name__ == "__main__":
    encrypted_text = "VTAOG"
    k = 2
    print("Encrypted:", encrypted_text)
    print("Decrypted:", simpleCipher(encrypted_text, k))  # TRYME
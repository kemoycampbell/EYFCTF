#this table contain the abc from a-z each
#abc is mapped to a specific number. for example a-> 0, b->1 etc up to z-> 25
#this allow us to map a letter to a number

#look_up_table = {
#    'a': 0, 'b': 1, 'c': 2, 'd': 3, 'e': 4, 'f': 5, 'g': 6, 
#    'h': 7, 'i': 8, 'j': 9, 'k': 10, 'l': 11, 'm': 12, 
#    'n': 13, 'o': 14, 'p': 15, 'q': 16, 'r': 17, 's': 18, 
#    't': 19, 'u': 20, 'v': 21, 'w': 22, 'x': 23, 'y': 24, 'z': 25
#}

#this will allow us to map a number to a letter
#reverse_look_up_table = {
#    0: 'a', 1: 'b', 2: 'c', 3: 'd', 4: 'e', 5: 'f', 6: 'g', 
#    7: 'h', 8: 'i', 9: 'j', 10: 'k', 11: 'l', 12: 'm', 
#    13: 'n', 14: 'o', 15: 'p', 16: 'q', 17: 'r', 18: 's', 
#    19: 't', 20: 'u', 21: 'v', 22: 'w', 23: 'x', 24: 'y', 25: 'z'
#}

look_up_table = {chr(i + 97): i for i in range(26)}
reverse_look_up_table = {v: k for k, v in look_up_table.items()}

# Get encrypted message
message = input("Enter message to decrypt: ")
decrypted_message = ""

# Decrypt each letter

# Loop through each character in the encrypted message
for letter in message:
    
    # Convert the letter to lowercase (to match keys in the lookup table)
    lower = letter.lower()
    
    # Check if the character is a lowercase letter that we want to decrypt
    if lower in look_up_table:
        
        # Look up the number (0-25) corresponding to the letter
        number = look_up_table[lower]
        
        # Subtract 3 to shift backward for decryption and wrap using modulo 26
        shift = (number - 3) % 26
        
        # Convert the shifted number back to a letter
        decrypted_letter = reverse_look_up_table[shift]
        
        # Add the decrypted letter to the result string
        decrypted_message += decrypted_letter
    else:
        # If the character is not a letter (e.g., space, punctuation), keep it as is
        decrypted_message += letter

print("Decrypted message:", decrypted_message)
        
        

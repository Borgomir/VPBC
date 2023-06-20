import binascii
from secret_sharing import reconstruct_secret


def convert_hex_to_points_list(file_path):
    hex_string_list = []

    with open(file_path, 'r') as file:
        hex_list = file.read().strip().split(',')

        for hex_str in hex_list:
            hex_str = ''.join(c for c in hex_str if c.isalnum())  # Remove non-hexadecimal characters

            if len(hex_str) % 2 != 0:  # Check if the length is odd
                hex_str = '0' + hex_str  # Add a leading zero

            try:
                ascii_str = binascii.unhexlify(hex_str).decode('utf-8')
                hex_string_list.append(ascii_str)
            except binascii.Error:
                print(f"Invalid hexadecimal string: {hex_str}")

    number_pairs_list = []

    for hex_str in hex_string_list:
        numbers = hex_str.strip('()').split(',')
        number_pairs_list.append(tuple(map(int, numbers)))

    return number_pairs_list


file_path = 'string_shares.txt'
result = convert_hex_to_points_list(file_path)
print(reconstruct_secret(result))

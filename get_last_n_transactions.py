import json
import sys


def get_last_n_transactions(file_path, n):
    with open(file_path, 'r') as file:
        data = json.load(file)

    last_n_transactions = data[-n:]
    result = []

    for transaction in last_n_transactions:
        result.extend(transaction['data'])

    return result


print(get_last_n_transactions("transacs.txt", int(sys.argv[1])))
#print(get_last_n_transactions(sys.argv[1], int(sys.argv[2])))

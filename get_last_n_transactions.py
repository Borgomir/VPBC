import json
import sys


def get_last_n_transactions(file_path1, file_path2=None, n=1):
    with open(file_path1, 'r') as file1:
        data1 = json.load(file1)

    if file_path2 is not None:
        with open(file_path2, 'r') as file2:
            data2 = json.load(file2)
        combined_data = data1 + data2
    else:
        combined_data = data1

    sorted_data = sorted(combined_data, key=lambda x: x['timereceived'], reverse=True)

    result = []
    count = 0

    for i in range(len(sorted_data)):
        current_transaction = sorted_data[i]
        result.extend(current_transaction['data'])
        count += 1

        if count == n:
            break

        if i < len(sorted_data) - 1:
            current_time = current_transaction['timereceived']
            next_time = sorted_data[i + 1]['timereceived']
            time_difference = next_time - current_time

            if time_difference > 3:
                break

    return result


print(get_last_n_transactions(sys.argv[1], sys.argv[2], int(sys.argv[3])))


"""
def get_last_n_transactions(file_path, n):
    with open(file_path, 'r') as file:
        data = json.load(file)

    last_n_transactions = data[-n:]
    result = []

    for transaction in last_n_transactions:
        result.extend(transaction['data'])

    return result
"""
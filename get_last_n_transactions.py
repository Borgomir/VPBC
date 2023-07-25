import json
import sys


def get_last_n_transactions(num_files, n):
    combined_data = []

    for i in range(num_files):
        file_path = f'transacs{i if i > 0 else ""}.txt'

        with open(file_path, 'r') as file:
            data = json.load(file)
            combined_data.extend(data)

    latest_transaction = max(combined_data, key=lambda x: x['timereceived'])
    latest_time = latest_transaction['timereceived']

    result = []
    count = 0

    for transaction in combined_data:
        if transaction['timereceived'] == latest_time or abs(transaction['timereceived'] - latest_time) <= 5:
            result.extend(transaction['data'])
            count += 1

        if count == n:
            break

    return result


print(get_last_n_transactions(int(sys.argv[1]), sys.argv[2]))

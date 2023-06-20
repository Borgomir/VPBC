file_path="transacs.txt"

echo "Please input the name of the blockchain:"
read blockchain_name

echo "Please input the threshold for reconstructing the secret:"
read n

multichain-cli "$blockchain_name" listwallettransactions > $file_path

python3 get_last_n_transactions.py "$n" > string_shares.txt

python3 convert_hex_to_points_list.py

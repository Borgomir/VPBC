echo "Please choose the type of communication (1 for homogeneous overlay, 2 for heterogeneous overlay)"
read type

case $type in
  "1")
    echo "Please input the name of the blockchain:"
    read blockchain_name

    ./init_blockchain.sh "$blockchain_name"

    blockchain_name2=0
  ;;
  "2")
    echo "Please input the name of the first blockchain:"
    read blockchain_name

    ./init_blockchain.sh "$blockchain_name"

    echo "Please input the name of the second blockchain:"
    read blockchain_name2

    ./init_blockchain.sh "$blockchain_name2"
  ;;
  *)
    echo "Wrong value"
    exit
  ;;
esac

echo "Please input the threshold for reconstructing the secret:"
read t

file_path="transacs.txt"
file_path2="transacs2.txt"



if [ $type == 2 ]; then
      multichain-cli "$blockchain_name" listwallettransactions > $file_path
      multichain-cli "$blockchain_name2" listwallettransactions > $file_path2
      python3 get_last_n_transactions.py "$file_path" "$file_path2" "$t" > string_shares.txt
    else
      multichain-cli "$blockchain_name" listwallettransactions > $file_path
      python3 get_last_n_transactions.py "$file_path" "$t" > string_shares.txt
fi

python3 convert_hex_to_points_list.py

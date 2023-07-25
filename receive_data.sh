echo "Please choose the type of communication (1 for homogeneous overlay, 2 for heterogeneous overlay)"
read type

case $type in
  "1")
    echo "Please input the number of multichain blockchains created and setup:"
    read number_blockchains

    ./test_init_blockchain.sh "$number_blockchains"
  ;;
  "2")
    echo "Feature not implemented yet"
    exit
  ;;
  *)
    echo "Wrong value"
    exit
  ;;
esac

echo "Please input the threshold for reconstructing the secret:"
read t


chain_name="testChain"

multichain-cli "${chain_name}" listwallettransactions > "transacs.txt"
for (( i = 1; i < $number_blockchains; i++ )); do
    multichain-cli "${chain_name}$i" listwallettransactions > "transacs${i}.txt"
done
python3 get_last_n_transactions.py "$number_blockchains" "$t" > string_shares.txt
python3 convert_hex_to_points_list.py

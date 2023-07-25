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

echo "Please input the number of shares to generate and send:"
read n

echo "Please input the secret:"
read secret

./send_secret_normal_method.sh "$t" "$n" "$secret" "$blockchain_name" "$type" "$blockchain_name2"

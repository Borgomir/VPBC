echo "Please choose the type of communication (1 for homogeneous overlay, 2 for heterogeneous overlay)"
read type

case $type in
  "1")
    echo "Please input the number of multichain blockchains created and setup:"
    read number_blockchains

    ./init_blockchain.sh "$number_blockchains"
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

echo "Please input the number of shares to generate and send:"
read n

echo "Please input the secret:"
read secret

#./send_secret_normal_method.sh "$t" "$n" "$secret" "$number_blockchains" "$type"
./send_secret_normal_method.sh "$t" "$n" "$secret" "$number_blockchains"

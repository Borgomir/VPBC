echo "Please input the name of the blockchain:"
read blockchain_name

./init_blockchain.sh "$blockchain_name"

echo "Please input the threshold for reconstructing the secret:"
read t

echo "Please input the number of shares to generate and send:"
read n

echo "Please input the secret:"
read secret

./send_secret_normal_method.sh "$t" "$n" "$secret" "$blockchain_name"

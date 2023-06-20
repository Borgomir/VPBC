echo "SENDING ASSET..."

# $1 name of the blockchain
# $2 node address
# $3 The share to send (x, y)


send_data="$(printf '%s' "$3" | hexdump -ve '/1 "%02X"')"
echo "$send_data"

multichain-cli "$1" sendwithdata "$2" '{"asset1":1}' "$send_data"
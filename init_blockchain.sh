echo "INITIALISING THE VPBC NODE..."

m=$1

chain_name="testChain"
multichaind "$chain_name" -daemon
for ((i=1; i<m; i++)); do
    multichaind "${chain_name}$i" -daemon
done

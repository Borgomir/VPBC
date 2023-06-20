echo "Sending shares for Shamir secret sharing:"

t=$1
n=$2
secret=$3
blockchain_name=$4

python3 gen_shares.py "$t" "$n" "$secret" > shares.txt

# Read the contents of shares.txt into a variable
file_content=$(cat shares.txt)

# Extract the pairs of numbers inside parentheses using regex
numbers=$(echo "$file_content" | grep -oP '\(\K\d+,\s*\d+\)')

# Store the pairs of numbers in an array
number_array=()
while read -r number_pair; do
    number_array+=("$number_pair")
done <<< "$numbers"

# Print each pair of numbers
for number_pair in "${number_array[@]}"; do
  number_pair="(""$number_pair"
  number_pair="${number_pair// /}"
  echo "$number_pair"
  ./send_asset.sh "$blockchain_name" "1WB1JAunu2sqxy9uxBRHkqC6TQ9enrZSJpKbrR" "$number_pair"
done

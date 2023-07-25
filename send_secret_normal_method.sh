echo "Sending shares for Shamir secret sharing:"

t=$1
n=$2
secret=$3
blockchain_name=$4
type=$5
blockchain_name2=$6

declare -i i=1

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
  if ([ "$type" == 2 ] && [ "$i" -ge "$t" ]); then
        ./send_asset.sh "$blockchain_name2" "1E9CyrtK1thWQyFYsvCxf65oFaJELcB8wmar93" "$number_pair"
      else
        ./send_asset.sh "$blockchain_name" "1WB1JAunu2sqxy9uxBRHkqC6TQ9enrZSJpKbrR" "$number_pair"
  fi
  i+=1
done



# testChain  : 1WB1JAunu2sqxy9uxBRHkqC6TQ9enrZSJpKbrR
# testChain1 : ###
# testChain2 : 1E9CyrtK1thWQyFYsvCxf65oFaJELcB8wmar93
# testChain3 : 13K4qCn5yfN2yMLop1ZY6NZekVEdBsL9m5ivxC
# testChain4 : ###
echo "Sending shares for Shamir secret sharing:"

t=$1
n=$2
secret=$3
number_blockchains=$4
#type=$5

chain_name="testChain"
address_list=("1WB1JAunu2sqxy9uxBRHkqC6TQ9enrZSJpKbrR" "1Fi4vxFzHm3AbQzGzERa3VZLs6sGqiugDfbe3k" "1E9CyrtK1thWQyFYsvCxf65oFaJELcB8wmar93" "13K4qCn5yfN2yMLop1ZY6NZekVEdBsL9m5ivxC")
declare -i i=0
declare -i num_sent_per_block=0

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
#while [ "$i" -ie "$num_shares" ]; do

#done


for number_pair in "${number_array[@]}"; do
  number_pair="(""$number_pair"
  number_pair="${number_pair// /}"
  echo "$number_pair"


  if [ "$i" == 0 ] && [ "$num_sent_per_block" -ge "$t" ]; then
      echo "$num_sent_per_block" -ge "$t"
      echo "Number of blockchains selected not sufficient for the operation"
      exit
    else
      num_sent_per_block+=1
  fi

  if [ "$i" == 0 ]; then
        ./send_asset.sh "$chain_name" "${address_list[i]}" "$number_pair"
        echo "Sent share in testChain"
      else
        ./send_asset.sh "${chain_name}$i" "${address_list[i]}" "$number_pair"
        echo "Sent share in testChain${i}"
  fi
  i+=1
  i=$((i%number_blockchains))
done



# testChain  : 1WB1JAunu2sqxy9uxBRHkqC6TQ9enrZSJpKbrR
# testChain1 : 1Fi4vxFzHm3AbQzGzERa3VZLs6sGqiugDfbe3k
# testChain2 : 1E9CyrtK1thWQyFYsvCxf65oFaJELcB8wmar93
# testChain3 : 13K4qCn5yfN2yMLop1ZY6NZekVEdBsL9m5ivxC
# testChain4 : ###
from secret_sharing import generate_shares

import sys

t = int(sys.argv[1])
n = int(sys.argv[2])
secret = int(sys.argv[3])
shares = generate_shares(n, t, secret)
print(shares)
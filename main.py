from sympy import randprime

from secret_sharing import generate_shares
from secret_sharing import reconstruct_secret
import sys
import random
prime_size = 2048
print("test")
prime = randprime(2 ** (prime_size - 1), 2 ** prime_size)
print("finished test")

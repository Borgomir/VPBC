import random
from secret_sharing import reconstruct_secret

FIELD_SIZE = 10 ** 5


def generate_shares_predef(n, t, secret, predef_shares):
    shares = []
    shares_send = []
    for i in range(len(predef_shares)):
        shares.append((predef_shares[i][0], predef_shares[i][1]))
        shares_send.append((predef_shares[i][0], predef_shares[i][1]))

    while len(shares) < t - 1:
        x = random.randrange(1, FIELD_SIZE)
        y = random.randrange(1, FIELD_SIZE)
        print(x, y)
        shares.append((x, y))
        shares_send.append((x, y))


    shares.append((0, secret))

    for i in range(t - 1, n):
        xp = random.randrange(1, FIELD_SIZE)
        yp = 0
        for j, share_j in enumerate(shares):
            xj, yj = share_j
            prod = 1

            for i, share_i in enumerate(shares):
                xi, _ = share_i
                if i != j:
                    prod *= (xi - xp) / (xi - xj)

            prod *= yj  # Convert yj to Decimal
            yp += prod
        shares_send.append((xp, yp))

    return shares_send


if __name__ == '__main__':
    # (3,5) sharing scheme
    t, n = 3, 5
    secret = random.randint(1, 1000)
    predef_shares = [(321, 4134), (645, 813)]
    print(f'Original Secret: {secret}')

    # Phase I: Generation of shares
    shares = generate_shares_predef(n, t, secret, predef_shares)
    print(f'Shares: {", ".join(str(share) for share in shares)}')

    # Phase II: Secret Reconstruction
    # Picking t shares randomly for
    # reconstruction
    pool = random.sample(shares, t)
    print(f'Combining shares: {", ".join(str(share) for share in pool)}')
    print(f'Reconstructed secret: {reconstruct_secret(pool)}')
#!/usr/bin/env python3

# Apache 2.0

import sys

# sys.argv[1], the original tokens.txt
# sys.argv[2], the space token

with open(sys.argv[1], 'r') as f:
    tokens = []
    for line in f:
        lc = line.strip().split()
        token = lc[0]
        tokenid = int(lc[1])
        if token == '<eps>':
            tokens.append(token)
            tokens.append("<space>")
        elif token == sys.argv[2]:
            pass
        elif '#' in token:
            tokens.append(token)
        else:
            tokens.append(token)
            tokens.append("%%"+token)

for i, token in enumerate(tokens):
    print(token, i)



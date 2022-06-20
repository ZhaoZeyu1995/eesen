#!/usr/bin/env python3

import argparse


def main(args):
    with open(args.vocabulary) as f:
        for line in f:

            lc = line.strip().split()
            word = lc[0]
            if word.startswith('<') and len(word) > 1:
                letters = word
                # dealing with special word <*>, e.g., <NOISE>, <space>
            else:
                letters = list(word)
                # for general words, we split it into letters
            print("%s %s" % (word, ' '.join(letters)))



if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description='This programme takes as input a list of words (or the first column of a lexicon) and prints out the raw lexicon file that should be uniq and sort to get lexicon.txt')
    parser.add_argument(
        'vocabulary', help='The vocabulary file, a list of words (a lexicon file, and it will only consider the first column).', type=str)
    args = parser.parse_args()
    main(args)

"""Subsample sequences in a FASTA.
"""

import argparse
from collections import OrderedDict
import random

from adapt.utils import seq_io

__author__ = 'Hayden Metsky <hayden@mit.edu>'


def main(args):
    seqs = seq_io.read_fasta(args.i)

    seqs_included = []
    to_include = random.sample(range(len(seqs)), args.n)
    for i, (name, seq) in enumerate(seqs.items()):
        if i in to_include:
            seqs_included += [(name, seq)]

    seq_io.write_fasta(OrderedDict(seqs_included), args.o)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('-i', required=True,
        help="Input FASTA file")
    parser.add_argument('-n', required=True, type=int,
        help="Number of sequences to sample")
    parser.add_argument('-o', required=True,
        help="Output FASTA file with sampled seqs")

    args = parser.parse_args()  

    main(args)

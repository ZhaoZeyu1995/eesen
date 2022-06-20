#!/bin/bash


# run this from ../
vocabulary=data/local/dict_phn/lexicon2_raw_nosil.txt
units=$HOME/Documents/Work/CSTR/lennoxtown/s3/espnet/egs/wsj/asr2/data/lang_1char/train_si284_units.txt
dir=data/local/dict_char_newctc
map_oov='<unk>'

. utils/parse_options.sh

mkdir -p $dir

# vocabulary can also be a lexicon or just a list of words
# units is a list of "units id" starting from 1
# dir is the local dict src directory where we store files for graph construction

# We need to prepare 3 files in $dir
# 1. lexicon.txt
# 2. units.txt
# 3. lexicon_numbers.txt

[ -f path.sh ] && . ./path.sh

./utils/generate_new_lexicon.py $vocabulary | uniq | sort > $dir/lexicon.txt

cp $units $dir/units.txt

# Convert character sequences into the corresponding sequences of units indices, encoded by units.txt
utils/sym2int.pl --map-oov $map_oov -f 2- $dir/units.txt < $dir/lexicon.txt > $dir/lexicon_numbers.txt
utils/int2sym.pl -f 2- $dir/units.txt < $dir/lexicon_numbers.txt > $dir/lexicon.txt

#!/bin/bash

. ./cmd.sh ## You'll want to change cmd.sh to something that will work on your system.
           ## This relates to the queue.
stage=1
wsj0=/path/to/LDC93S6B
wsj1=/path/to/LDC94S13B

. utils/parse_options.sh

if [ $stage -le 1 ]; then
  echo =====================================================================
  echo "             Data Preparation and FST Construction                 "
  echo =====================================================================

  if [ ! -f data/local/dict_phn/lexicon2_raw_nosil.txt ]; then
     echo "Could not find data/local/dict_phn/lexicon2_raw_nosil.txt. Execute stage 1 of run_ctc_phn.sh before running this script";
     exit 1;
  fi

  # Represent word spellings using a dictionary-like format
  local/wsj_prepare_dict_newctc.sh || exit 1;

  # Compile the lexicon and token FSTs
  utils/newctc_compile_dict_token.sh --space-char "<space>" \
    data/local/dict_char_newctc data/local/lang_newctc_tmp data/lang_newctc || exit 1;

  # Compile the language-model FST and the final decoding graph TLG.fst
  local/wsj_decode_graph.sh data/lang_newctc || exit 1;
fi

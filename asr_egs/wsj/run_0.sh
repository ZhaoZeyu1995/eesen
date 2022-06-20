#!/bin/bash

. ./cmd.sh ## You'll want to change cmd.sh to something that will work on your system.
           ## This relates to the queue.

stage=1
wsj0=/path/to/LDC93S6B
wsj1=/path/to/LDC94S13B
corpus=/group/corporapublic/wsj

. utils/parse_options.sh

# add check for IRSTLM prune-lm
if ! prune-lm > /dev/null 2>&1; then
    echo "Error: prune-lm (part of IRSTLM) is not in path"
    echo "Make sure that you run tools/extras/install_irstlm.sh in the main Eesen directory;"
    echo " this is no longer installed by default."
    exit 1
fi


if [ $stage -le 1 ]; then
  echo =====================================================================
  echo "             Data Preparation and FST Construction                 "
  echo =====================================================================
  # Use the same datap prepatation script from Kaldi
  local/cstr_wsj_data_prep.sh ${corpus}  || exit 1;

  # Construct the phoneme-based lexicon from the CMU dict
  local/wsj_prepare_phn_dict.sh || exit 1;

  # Compile the lexicon and token FSTs
  utils/ctc_compile_dict_token.sh data/local/dict_phn data/local/lang_phn_tmp data/lang_phn || exit 1;

  # Compile the language-model FST and the final decoding graph TLG.fst
  local/wsj_decode_graph.sh data/lang_phn || exit 1;
fi

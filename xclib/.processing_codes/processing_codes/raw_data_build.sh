#!/usr/bin/env bash

: '

Created by XC group

$1 -> 	Dataset

complete_doc.txt ->	contains single file of raw data for both test and train in format 
					(id->text) with not headers
split.0.txt      -> contains split of test and train with 0 for train
labels.txt 		 -> contains single file if raw data having ids of label present in each 
					document with headers present (<Total docs> <Total labels>)	

'

PREPROCESS=$(pwd)/scripts/pl/elseProcess.perl
TOKENIZER=$(pwd)/scripts/py/raw_tf_idf.py

work_dir="${HOME}/scratch/lab/Workspace"
datasets="${work_dir}/data/${1}"

ROOT=$datasets
mkdir -p $ROOT
X=$datasets'/corpus_text.txt'
SPLIT=$datasets'/split.0.txt'
TLOWX=$ROOT'/low_X.txt'
LBMAT=$datasets'/corpus_lbl_mat.txt'
TEMP=$ROOT'/temp.txt'

clean_text(){
	echo "USING STD TOKENIZER"
	python -u $TOKENIZER $1 $2 $3 $4 $5 $6 $7
}

# awk -F '->' '{$1=""; print $0}' $X | perl $PREPROCESS >$TLOWX
cat $X | perl $PREPROCESS >$TLOWX
clean_text $ROOT $TLOWX $SPLIT "${LBMAT}" $ROOT'/train_text.txt' $ROOT'/test_text.txt'
rm -rf $TLOWX

T=1000    # average size of transaction -tlen 
P=5     # average length of maximal patterns -seq.patlen
I=100   # number of differernt items -nitems
C=0.25  # correlation grade among patterns -lit.corr
D=10    # number of transactions -ncust

DATASET=T$T-P$P-I$I-C$C-D$D
OUTPUT=output/$DATASET

echo "P1: Generating new dataset: $DATASET"
./seq_data_generator seq -tlen $T -seq.patlen $P -nitems $I -lit.corr $C -ncust $D -ascii -fname $OUTPUT
# ./seq_data_generator seq -slen 6 -tlen 29 -nitems 0.05 -ascii -fname $OUTPUT

echo "P2: Cleaning/Reformatting dataset"
python3 ./clean2.py $OUTPUT.data

echo "P3: Generating dataset statistics"
python3 ./calc_statistics.py $OUTPUT.data.cl >> $OUTPUT.txt

echo "P4: Removing junk files"
rm -f $OUTPUT.data
rm -f $OUTPUT.pat

echo "Done!"

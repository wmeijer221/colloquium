
CONFIGURATIONS=(
    # Different sizes
    50 5 100 0.25 50
    50 5 100 0.25 100
    50 5 100 0.25 250
    50 5 100 0.25 500
    50 5 100 0.25 1000
    50 5 100 0.25 2000

    # Different densities
    10 5 100 0.25 500
    25 5 100 0.25 500
    50 5 100 0.25 500
    100 5 100 0.25 500
    250 5 100 0.25 500
    500 5 100 0.25 500
)

mkdir ./datasets/ibm

for ((i=0;i<60;i+=5))
do 
    : 
    T=${CONFIGURATIONS[i]}      # average size of transaction -tlen 
    P=${CONFIGURATIONS[i+1]}    # average length of maximal patterns -seq.patlen
    I=${CONFIGURATIONS[i+2]}    # number of differernt items -nitems
    C=${CONFIGURATIONS[i+3]}    # correlation grade among patterns -lit.corr
    D=${CONFIGURATIONS[i+4]}    # number of transactions -ncust

    DATASET="T$T-P$P-I$I.k-C$C-D$D.k"
    OUTPUT="./datasets/ibm/$DATASET"

    echo "P1: Generating new dataset: $DATASET"
    ./repositories/ibm_generator/seq_data_generator lit -ntrans $D -tlen $T -nitems $I -patlen $P -corr $C -ascii -fname $OUTPUT

    echo "P2: Cleaning/Reformatting dataset"
    python3 ./src/generate_datasets/clean.py $OUTPUT.data

    echo "P3: Generating dataset statistics"
    python3 ./src/generate_datasets/calc_statistics.py $OUTPUT.data.cl >> $OUTPUT.pat

    echo "P4: Removing junk files"
    rm -f $OUTPUT.data
    mv $OUTPUT.data.cl $OUTPUT.dat

    echo "Done!"
done

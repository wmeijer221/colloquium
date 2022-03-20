#!/bin/sh
# This script executes the entire GMiner support threshold experiment.

D=500
T=20
I=1
MIN_SUP=(0.0001 0.0002 0.0003 0.0004 0.0005 0.0006 0.0007 0.0008 0.0009 0.001)

REPS=10

echo -e "Starting Density Experiment"

echo -e "Step 1: Generating dataset"
DATA_DIR="./datasets/ibm"
FNAME="D${D}K-T${T}-I${I}K"

./repositories/ibm_generator/seq_data_generator lit -ntrans $D -nitems $I -tlen $T -ascii -fname "$DATA_DIR/$FNAME"
python3 ./src/generate_datasets/clean2.py "$DATA_DIR/$FNAME.data"
python3 ./src/generate_datasets/calc_statistics.py "$DATA_DIR/$FNAME.data.cl" >> "$DATA_DIR/$FNAME.pat"


echo -e "Step 2: Intermediary Clean-up"
rm $DATA_DIR/**.data
mv "$DATA_DIR/$FNAME.data.cl" "$DATA_DIR/$FNAME.dat"


for s in "${MIN_SUP[@]}"
do 
    :
    echo -e "Step 3: Perform experiment (Support: $s)"
    RESULT_DIR="./results/gminer"

    echo -e "Dataset: $FNAME\nRepetitions: $REPS\nMinimum Support: $s\n\n" >> "$RESULT_DIR/$FNAME-s$s.out"

    for ((i=1; i<=$REPS; i+=1))
    do 
        :
        echo -e "Repetition $i/$REPS"
        echo -e "\n\nRepetition: $i / $REPS" >> "$RESULT_DIR/$FNAME-s$s.out"
        ./repositories/gminer/GMiner -i "$DATA_DIR/$FNAME.dat" -o "$RESULT_DIR/$FNAME.dat" -s $s -w 1 >> "$RESULT_DIR/$FNAME-s$s.out"
    done


    echo -e "Step 4: Final clean-up"
    echo -e "\n\nGenerated Pattern File:\n" >> "$RESULT_DIR/$FNAME-s$s.out"
    cat "$DATA_DIR/$FNAME.pat" >> "$RESULT_DIR/$FNAME-s$s.out"

    echo -e "\n\nFound Patterns:\n" >> "$RESULT_DIR/$FNAME-s$s.out"
    cat "$RESULT_DIR/$FNAME.dat" >> "$RESULT_DIR/$FNAME-s$s.out"
    
done

rm "$DATA_DIR/$FNAME.pat"
rm "$RESULT_DIR/$FNAME.dat"

echo -e "Step 5: Done!\n"

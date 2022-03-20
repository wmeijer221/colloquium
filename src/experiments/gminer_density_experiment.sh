#!/bin/sh
# This script executes the entire GMiner data-density experiment.

D=500
T=(10 20 30 40 50)
I=1

REPS=10
MIN_SUP=0.0005

echo -e "Starting Density Experiment"

for t in "${T[@]}"
do 
    :
    echo -e "Step 1: Generating dataset (T: $t)"
    DATA_DIR="./datasets/ibm"
    FNAME="D${D}K-T${t}-I${I}K"

    ./repositories/ibm_generator/seq_data_generator lit -ntrans $D -nitems $I -tlen $t -ascii -fname "$DATA_DIR/$FNAME"
    python3 ./src/generate_datasets/clean2.py "$DATA_DIR/$FNAME.data"
    python3 ./src/generate_datasets/calc_statistics.py "$DATA_DIR/$FNAME.data.cl" >> "$DATA_DIR/$FNAME.pat"


    echo -e "Step 2: Intermediary Clean-up"
    rm $DATA_DIR/**.data
    mv "$DATA_DIR/$FNAME.data.cl" "$DATA_DIR/$FNAME.dat"


    echo -e "Step 3: Perform experiment"
    RESULT_DIR="./results/gminer"


    echo -e "Dataset: $FNAME\nRepetitions: $REPS\nMinimum Support: $MIN_SUP\n\n" >> "$RESULT_DIR/$FNAME.out"

    for ((i=1; i<=$REPS; i+=1))
    do 
        :
        echo -e "Repetition $i/$REPS"
        echo -e "\n\nRepetition: $i / $REPS" >> "$RESULT_DIR/$FNAME.out"
        ./repositories/gminer/GMiner -i "$DATA_DIR/$FNAME.dat" -o "$RESULT_DIR/$FNAME.dat" -s $MIN_SUP -w 1 >> "$RESULT_DIR/$FNAME.out"
    done


    echo -e "Step 4: Final clean-up"
    echo -e "\n\nGenerated Pattern File:\n" >> "$RESULT_DIR/$FNAME.out"
    cat "$DATA_DIR/$FNAME.pat" >> "$RESULT_DIR/$FNAME.out"
    rm "$DATA_DIR/$FNAME.pat"

    echo -e "\n\nFound Patterns:\n" >> "$RESULT_DIR/$FNAME.out"
    cat "$RESULT_DIR/$FNAME.dat" >> "$RESULT_DIR/$FNAME.out"
    rm "$RESULT_DIR/$FNAME.dat"

    echo -e "Step 5: Done!\n"
done

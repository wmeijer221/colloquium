#!/bin/sh
# This script executes the entire GMiner support threshold experiment.

I=1
D=(100 250 500 1000)
T=(10 25 40 55)
MIN_SUP=(0.002)

REPS=2
DATA_DIR="./datasets/ibm"
RESULT_DIR="./results/gminer"

echo -e "Starting Experiment"

for d in "${D[@]}"
do 
    :
    for t in "${T[@]}"
    do 
        :

        FNAME="D${d}K-T${t}-I${I}K"
        # echo -e "\nStep 1: Generating dataset: $FNAME"

        # ./repositories/ibm_generator/seq_data_generator lit -ntrans $d -nitems $I -tlen $t -ascii -fname "$DATA_DIR/$FNAME"
        # python3 ./src/generate_datasets/clean2.py "$DATA_DIR/$FNAME.data"
        # python3 ./src/generate_datasets/calc_statistics.py "$DATA_DIR/$FNAME.data.cl" >> "$DATA_DIR/$FNAME.pat"


        # echo -e "Step 2: Intermediary Clean-up"
        # rm $DATA_DIR/**.data
        # mv "$DATA_DIR/$FNAME.data.cl" "$DATA_DIR/$FNAME.dat"


        for s in "${MIN_SUP[@]}"
        do
            : 
            echo -e "Step 3: Perform experiment (Support: $s)"
            echo -e "Dataset: $FNAME\nRepetitions: $REPS\nMinimum Support: $s\n\n" >> "$RESULT_DIR/$FNAME-s$s.out"
            
            for ((i=1; i <=$REPS; i+=1))
            do 
                :
                echo -e "Repetition $i/$REPS"
                echo -e "\n\nRepetition: $i / $REPS" >> "$RESULT_DIR/$FNAME-s$s.out"

                ./repositories/gminer/GMiner -i "$DATA_DIR/$FNAME.dat" -o "$RESULT_DIR/$FNAME.dat" -s $s -w 1 >> "$RESULT_DIR/$FNAME-s$s.out"
            done

            echo -e "Step 4: Final clean-up"
            echo -e "\n\nGenerated Pattern File:\n" >> "$RESULT_DIR/$FNAME-s$s.out"
            cat "$DATA_DIR/$FNAME.pat" >> "$RESULT_DIR/$FNAME-s$s.out"
        done 

        # rm "$DATA_DIR/$FNAME.pat"
        rm "$RESULT_DIR/$FNAME.dat"
    done
done 

echo -e "Step 5: Done!\n"

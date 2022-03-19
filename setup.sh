
#TODO: update this file.

# downloads FIMI'04 datasets. 
./src/setup/download_fimi_data.sh 

# Downloads relevant repositories and applies changes to them.
./src/setup/download_repos.sh
./src/gminer_changes/apply_gminer_changes.sh

# Generates synthetic datasets.
./src/generate_datasets/generate.sh

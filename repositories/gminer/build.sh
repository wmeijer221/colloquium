echo build executable files...
nvcc -O3 -Xcompiler -fPIC -w -Xcompiler -fopenmp -gencode arch=compute_30,code=sm_30 -gencode arch=compute_32,code=sm_32 -gencode arch=compute_35,code=sm_35 -gencode arch=compute_37,code=sm_37 -gencode arch=compute_50,code=sm_50 -gencode arch=compute_52,code=sm_52 -gencode arch=compute_53,code=sm_53 -gencode arch=compute_60,code=sm_60  -odir "" -M -o "data.d" "data.cpp"

nvcc -O3 -Xcompiler -fPIC -w -Xcompiler -fopenmp --compile  -x c++ -o  "data.o" "data.cpp"
nvcc -O3 -Xcompiler -fPIC -w -Xcompiler -fopenmp -gencode arch=compute_30,code=sm_30 -gencode arch=compute_32,code=sm_32 -gencode arch=compute_35,code=sm_35 -gencode arch=compute_37,code=sm_37 -gencode arch=compute_50,code=sm_50 -gencode arch=compute_52,code=sm_52 -gencode arch=compute_53,code=sm_53 -gencode arch=compute_60,code=sm_60  -odir "" -M -o "main.d" "main.cu"

nvcc -O3 -Xcompiler -fPIC -w -Xcompiler -fopenmp --compile --relocatable-device-code=false -gencode arch=compute_30,code=compute_30 -gencode arch=compute_32,code=compute_32 -gencode arch=compute_35,code=compute_35 -gencode arch=compute_37,code=compute_37 -gencode arch=compute_50,code=compute_50 -gencode arch=compute_52,code=compute_52 -gencode arch=compute_53,code=compute_53 -gencode arch=compute_60,code=compute_60 -gencode arch=compute_30,code=sm_30 -gencode arch=compute_32,code=sm_32 -gencode arch=compute_35,code=sm_35 -gencode arch=compute_37,code=sm_37 -gencode arch=compute_50,code=sm_50 -gencode arch=compute_52,code=sm_52 -gencode arch=compute_53,code=sm_53 -gencode arch=compute_60,code=sm_60  -x cu -o  "main.o" "main.cu"

nvcc --cudart static --relocatable-device-code=false -gencode arch=compute_30,code=compute_30 -gencode arch=compute_32,code=compute_32 -gencode arch=compute_35,code=compute_35 -gencode arch=compute_37,code=compute_37 -gencode arch=compute_50,code=compute_50 -gencode arch=compute_52,code=compute_52 -gencode arch=compute_53,code=compute_53 -gencode arch=compute_60,code=compute_60 -gencode arch=compute_30,code=sm_30 -gencode arch=compute_32,code=sm_32 -gencode arch=compute_35,code=sm_35 -gencode arch=compute_37,code=sm_37 -gencode arch=compute_50,code=sm_50 -gencode arch=compute_52,code=sm_52 -gencode arch=compute_53,code=sm_53 -gencode arch=compute_60,code=sm_60 -link -o  "GMiner"  data.o main.o   -lgomp
rm *.o
rm *.d
echo done.

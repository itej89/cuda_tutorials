#include <algorithm>
#include <iostream>
#include <vector>


#include <cuda_runtime.h>



__global__ void vectorAdd(int* a, int* b, int* c, int n) {

    int tid = (blockIdx.x * blockDim.x) + threadIdx.x;
    if(tid < n) {
        c[tid] = a[tid] + b[tid];
    }

}


int main() {

   constexpr int N = 100;
    constexpr size_t bytes = sizeof(int) * N;

    std::vector<int> a(N);
    std::vector<int> b(N);
    std::vector<int> c(N);

    // Populate vectors a and b using std::for_each
    int x=0;

    
    std::for_each(a.begin(), a.end(), [&x](int& val) { val = x++; });
    x=0;
    std::for_each(b.begin(), b.end(), [&x](int& val) { val = x++; });

    int* d_a, *d_b, *d_c;
    cudaMalloc(&d_a, bytes);
    cudaMalloc(&d_b, bytes);
    cudaMalloc(&d_c, bytes);

    // Corrected cudaMemcpy calls
    cudaMemcpy(d_a, a.data(), bytes, cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, b.data(), bytes, cudaMemcpyHostToDevice);

    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (N + NUM_THREADS - 1) / NUM_THREADS;

    vectorAdd<<<NUM_BLOCKS, NUM_THREADS>>>(d_a, d_b, d_c, N);

    cudaMemcpy(c.data(), d_c, bytes, cudaMemcpyDeviceToHost);

    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);

    // Print the output array
    std::cout << "Output array:\n";
    for (int i = 0; i < N; ++i) {
        std::cout << c[i] << " ";
    }
    std::cout << "\nCOMPLETED SUCCESSFULLY\n";

    return 0;
}
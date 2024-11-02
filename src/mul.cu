
__global__ void
mul2_cuda_impl (
    int *xs,
    const size_t n
    )
{
    int i = blockDim.x * blockIdx.x + threadIdx.x;
    if (i < n) {
        xs[i] *= 2;
    }
}

extern "C" void
mul2_cuda (
    int *xs,
    const size_t n
    )
{
    size_t bytes = n * sizeof(int);

    int *dev_xs;
    cudaMalloc(&dev_xs, bytes);
    cudaMemcpy(dev_xs, xs, bytes, cudaMemcpyHostToDevice);

    dim3 block(1024);
    dim3 grid((n + block.x - 1) / block.x);
    mul2_cuda_impl<<<grid, block>>>(dev_xs, n);

    cudaMemcpy(xs, dev_xs, bytes, cudaMemcpyDeviceToHost);
    cudaFree(dev_xs);
    cudaDeviceReset();
}

extern "C" void
mul2_cuda_copy (
    const int *xs,
    int *ys,
    const size_t n
    )
{
    size_t bytes = n * sizeof(int);

    int *dev_xs;
    cudaMalloc(&dev_xs, bytes);
    cudaMemcpy(dev_xs, xs, bytes, cudaMemcpyHostToDevice);

    dim3 block(1024);
    dim3 grid((n + block.x - 1) / block.x);
    mul2_cuda_impl<<<grid, block>>>(dev_xs, n);

    cudaMemcpy(ys, dev_xs, bytes, cudaMemcpyDeviceToHost);
    cudaFree(dev_xs);
    cudaDeviceReset();
}

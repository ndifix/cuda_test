
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

__global__ void
mul_cuda_impl (
    int *a,
    int *b,
    int *c,
    const size_t n
    )
{
    int i = blockDim.x * blockIdx.x + threadIdx.x;
    if (i < n) {
        c[i] = a[i] * b[i];
    }
}

extern "C" void
mul_cuda (
    int *as,
    int *bs,
    int *cs,
    const size_t n
    )
{
    size_t bytes = n * sizeof(int);

    int *dev_as, *dev_bs, *dev_cs;
    cudaMalloc(&dev_as, bytes);
    cudaMalloc(&dev_bs, bytes);
    cudaMalloc(&dev_cs, bytes);
    cudaMemcpy(dev_as, as, bytes, cudaMemcpyHostToDevice);
    cudaMemcpy(dev_bs, bs, bytes, cudaMemcpyHostToDevice);

    dim3 block(1024);
    dim3 grid((n + block.x - 1) / block.x);
    mul_cuda_impl<<<grid, block>>>(dev_as, dev_bs, dev_cs, n);

    cudaMemcpy(cs, dev_cs, bytes, cudaMemcpyDeviceToHost);
    cudaFree(dev_as);
    cudaFree(dev_bs);
    cudaFree(dev_cs);
    cudaDeviceReset();
}

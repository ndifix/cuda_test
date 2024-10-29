extern "C" {

int add_int(int a, int b) {
    return a + b;
}

void
vector_add_int (
    const int* a,
    const int* b,
    int* c,
    int n
    )
{
    for (int i = 0; i < n; i++) {
        c[i] = a[i] + b[i];
    }
}

}

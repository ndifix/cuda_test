fn main() {
  cc::Build::new().file("src/add.cpp").compile("libadd.a");

  cc::Build::new()
    .cuda(true)
    .file("src/mul.cu")
    .compile("libcuda_mul.a");
}

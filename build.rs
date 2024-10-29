fn main() {
  cc::Build::new().file("src/add.cpp").compile("libadd.a");
}

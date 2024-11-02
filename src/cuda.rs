
extern "C" {
    #[allow(dead_code)]
    fn mul2_cuda(xs: *mut i32, n: usize);
}

#[cfg(test)]
mod test {
    #[test]
    fn vector_mul2_int_cuda_1() {
        let mut a = [0, 1, 2, 3];
        let expect = [0, 2, 4, 6];
        unsafe {
            super::mul2_cuda(a.as_mut_ptr(), 4);
        }

        assert_eq!(a, expect);
    }
}

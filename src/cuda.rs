
extern "C" {
    #[allow(dead_code)]
    fn mul2_cuda(xs: *mut i32, n: usize);
    #[allow(dead_code)]
    fn mul2_cuda_copy(xs: *const i32, ys: *mut i32, n: usize);
    #[allow(dead_code)]
    fn mul_cuda(a: *const i32, b: *const i32, c: *mut i32, n: usize);
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

    #[test]
    fn vector_mul2_int_cuda_copy_1() {
        let a = [0, 1, 2, 3];
        let mut b = [0; 4];
        let expect = [0, 2, 4, 6];
        unsafe {
            super::mul2_cuda_copy(a.as_ptr(), b.as_mut_ptr(), 4);
        }

        assert_eq!(b, expect);
    }

    #[test]
    fn vector_mul_int_cuda_1() {
        let a = [0, 1, 2, 3];
        let b = [5, 3, 4, 2];
        let mut c = [0; 4];
        let expect = [0, 3, 8, 6];
        unsafe {
            super::mul_cuda(a.as_ptr(), b.as_ptr(), c.as_mut_ptr(), 4);
        }

        assert_eq!(c, expect);
    }
}

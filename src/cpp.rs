extern "C" {
    #[allow(dead_code)]
    fn add_int(a: i32, b: i32) -> i32;

    #[allow(dead_code)]
    fn vector_add_int(a: *const i32, b: *const i32, c: *mut i32, n: i32);
}

#[cfg(test)]
mod test {
    #[test]
    fn add_int_1() {
        let result = unsafe { super::add_int(1, 2) };
        assert_eq!(result, 3);
    }

    #[test]
    fn vector_add_int_1() {
        let a = [0, 1, 2, 3];
        let b = [2, 4, 6, 8];
        let mut c = [0, 0, 0, 0];
        let expect = [2, 5, 8, 11];
        unsafe {
            super::vector_add_int(a.as_ptr(), b.as_ptr(), c.as_mut_ptr(), 4);
        }

        assert_eq!(c, expect);
    }
}

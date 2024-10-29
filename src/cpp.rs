extern "C" {
    #[allow(dead_code)]
    fn add_int(a: i32, b: i32) -> i32;
}

#[cfg(test)]
mod test {
    #[test]
    fn add_int_1() {
        let result = unsafe { super::add_int(1, 2) };
        assert_eq!(result, 3);
    }
}

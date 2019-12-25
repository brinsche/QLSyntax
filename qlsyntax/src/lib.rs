use std::ffi::CString;

#[no_mangle]
pub extern "C" fn hello_world() -> CString {
    CString::new("<html><body><h1>Hi from Rust!</h1></body></html>").unwrap()
}

#[cfg(test)]
mod tests {
    #[test]
    fn it_works() {
        assert_eq!(2 + 2, 4);
    }
}

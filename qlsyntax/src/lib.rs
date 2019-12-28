use std::ffi::{CStr, CString};
use std::fs::read_to_string;
use std::os::raw::c_char;
use std::path::Path;

use syntect::highlighting::{Color, ThemeSet};
use syntect::html::highlighted_html_for_string;
use syntect::parsing::SyntaxSet;

#[no_mangle]
pub extern "C" fn syntax_highlight(
    path: *const c_char,
    font: *const c_char,
    font_size: *const c_char,
    theme_name: *const c_char,
    theme_directory: *const c_char,
    syntax_directory: *const c_char,
) -> *const c_char {
    let path = unsafe {
        CStr::from_ptr(path)
            .to_str()
            .expect("Converting path failed")
    };
    let path = Path::new(&path);

    let font = unsafe { CStr::from_ptr(font).to_str().expect("Invalid font arg") };
    let font_size = unsafe {
        CStr::from_ptr(font_size)
            .to_str()
            .expect("Invalid font size arg")
    };
    let theme_name = unsafe {
        CStr::from_ptr(theme_name)
            .to_str()
            .expect("Invalid theme name arg")
    };
    let theme_dir = unsafe {
        CStr::from_ptr(theme_directory)
            .to_str()
            .expect("Invalid theme directory arg")
    };
    let syntax_dir = unsafe {
        CStr::from_ptr(syntax_directory)
            .to_str()
            .expect("Invalid syntax directory arg")
    };

    let buffer = read_to_string(path).expect("Failed to read file");
    let mut html = String::new();

    let syntax_set = SyntaxSet::load_defaults_newlines();
    let theme_set = ThemeSet::load_defaults();
    let theme = theme_set
        .themes
        .get(theme_name)
        .expect("Failed getting theme");

    let syntax = syntax_set
        .find_syntax_for_file(path)
        .expect("Failed finding syntax for file")
        .unwrap_or_else(|| syntax_set.find_syntax_plain_text());

    let bg = theme.settings.background.unwrap_or(Color::WHITE);
    let fg = theme.settings.foreground.unwrap_or(Color::BLACK);

    html.push_str(&format!(
        "<head><style> pre {{ font-family: {}; font-size: {}px; }} </style></head>",
        font, font_size
    ));
    html.push_str(&format!(
        "<body style=\"background-color:#{:02x}{:02x}{:02x}; white-space: pre-wrap; font-size: {}px; font-family: {}; color:#{:02x}{:02x}{:02x};\">",
        bg.r, bg.g, bg.b, "14", "mononoki", fg.r, fg.g, fg.b,
    ));

    html.push_str(&highlighted_html_for_string(
        &buffer,
        &syntax_set,
        &syntax,
        &theme,
    ));

    let html_ffi = CString::new(html).expect("Failed converting result to CString");
    let html_pointer = html_ffi.as_ptr();
    std::mem::forget(html_ffi);

    html_pointer
}

use std::fs::read_to_string;
use std::io::Cursor;
use std::os::raw::c_char;
use std::path::Path;

use ffi_support::{FfiStr, define_string_destructor, rust_string_to_c};
use syntect::highlighting::{Color, ThemeSet};
use syntect::html::highlighted_html_for_string;
use syntect::parsing::SyntaxSet;

define_string_destructor!(qlsyntax_destroy_string);

#[no_mangle]
pub extern "C" fn syntax_highlight(
    path: FfiStr,
    font: FfiStr,
    font_size: FfiStr,
    theme_name: FfiStr,
    theme_directory: FfiStr,
    syntax_directory: FfiStr,
) -> *const c_char {
    let buffer = read_to_string(path.as_str()).expect("Failed to read file");

    let mut theme_set = ThemeSet::load_defaults();
    let default_theme = ThemeSet::load_from_reader(&mut Cursor::new(
        &include_bytes!("../res/XCodelike.tmTheme")[..],
    )).unwrap();

    theme_set
        .add_from_folder(Path::new(theme_directory.as_str()))
        .unwrap_or_else(|e| println!("{}",&e.to_string()));

    let theme = theme_set
        .themes
        .get(theme_name.as_str())
        .unwrap_or(&default_theme)
        .clone();

    let mut syntax_builder = SyntaxSet::load_defaults_newlines().into_builder();
    syntax_builder
        .add_from_folder(&Path::new(syntax_directory.as_str()), true)
        .unwrap_or_else(|e| println!("{}", &e.to_string()));
        
    let syntax_set = syntax_builder.build();
    let syntax = syntax_set
        .find_syntax_for_file(path.as_str())
        .expect("Failed finding syntax for file")
        .unwrap_or_else(|| syntax_set.find_syntax_plain_text());

    let bg = theme.settings.background.unwrap_or(Color::WHITE);
    let fg = theme.settings.foreground.unwrap_or(Color::BLACK);

    let mut html = String::new();
    html.push_str(&format!(
        "<head><style> pre {{ font-family: {}; font-size: {}px; }} </style></head>",
        font.as_str(), font_size.as_str()
    ));
    html.push_str(&format!(
        "<body style=\"background-color:#{:02x}{:02x}{:02x}; white-space: pre-wrap; font-size: {}px; font-family: {}; color:#{:02x}{:02x}{:02x};\">",
        bg.r, bg.g, bg.b, font.as_str(), font_size.as_str(), fg.r, fg.g, fg.b,
    ));

    html.push_str(&highlighted_html_for_string(
        &buffer,
        &syntax_set,
        &syntax,
        &theme,
    ).unwrap());

    return rust_string_to_c(html)
}

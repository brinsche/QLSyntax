//
//  qlsyntax.h
//  QLSyntaxPlugin
//
//  Created by Bastian Rinsche on 25.12.19.
//  Copyright © 2019 Bastian Rinsche. All rights reserved.
//

const char* syntax_highlight(const char* path,
                             const char* font,
                             const char* font_size,
                             const char* theme_name,
                             const char* theme_directory,
                             const char* syntax_directory);

void qlsyntax_destroy_string(const char* s);

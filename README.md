Bin-Build
=========

[![Issues](http://img.shields.io/github/issues/macmade/Bin-Build.svg?style=flat)](https://github.com/macmade/Bin-Build/issues)
![Status](https://img.shields.io/badge/status-inactive-lightgray.svg?style=flat)
![License](https://img.shields.io/badge/license-bsd-brightgreen.svg?style=flat)
[![Contact](https://img.shields.io/badge/contact-@macmade-blue.svg?style=flat)](https://twitter.com/macmade)  
[![Donate-Patreon](https://img.shields.io/badge/donate-patreon-yellow.svg?style=flat)](https://patreon.com/macmade)
[![Donate-Gratipay](https://img.shields.io/badge/donate-gratipay-yellow.svg?style=flat)](https://www.gratipay.com/macmade)
[![Donate-Paypal](https://img.shields.io/badge/donate-paypal-yellow.svg?style=flat)](https://paypal.me/xslabs)

About
-----

Bin-Build is a small shell script to simplify compiling source file in C, C++ and Objective-C.

Documentation
-------------

### Overview

The purpose of this script is to provide a simplified compilation command.

When compiling a source file, the invocation of the compiler is often a painful task, especially when specific options need to be passed, like compiler flags, error level, etc.

For instance, in order to compile a C file with GCC, you need to type the following kind of command:

    gcc -Wall -Werror -Wextra -pedantic -std=c89 -Os -o file file.c

It can be a lot worse if using specific options.

With Bin-Build, you can replace the previous command with:

    bin-build file.c
    
It will generate a 'file' executable, from the 'file.c' source file, using the C compiler.
You will see the following kind of output:

    /usr/local/bin/bin-build: compiling file file.c
    
    Settings:
    
        - Language:       C
        - Compiler:       /usr/bin/gcc
        - Input file:     /Users/macmade/Desktop/test.c
        - Output file:    /Users/macmade/Desktop/test
    
    Compiler options:
       - std=c99                         - Os                              - pedantic
       - Werror                          - Wall                            - Wextra
       - Wbad-function-cast              - Wdeclaration-after-statement    - Werror-implicit-function-declaration
       - Wmissing-braces                 - Wmissing-declarations           - Wmissing-field-initializers
       - Wmissing-prototypes             - Wnested-externs                 - Wold-style-definition
       - Wparentheses                    - Wreturn-type                    - Wshadow
       - Wsign-compare                   - Wstrict-prototypes              - Wswitch
       - Wuninitialized                  - Wunknown-pragmas                - Wunused-function
       - Wunused-label                   - Wunused-parameter               - Wunused-value
       - Wunused-variable

    Compiling file...
    
    Compilation successfull
    Do you want to execute the produced binary now? [y/N]
    
    --------------------------------------------------------------------------------
    Executing /Users/macmade/Desktop/test
    --------------------------------------------------------------------------------
    
    --------------------------------------------------------------------------------
    Process exit code: 0
    --------------------------------------------------------------------------------

As you can see, once the compilation is complete, the script ask you if you want to execute the produced program, and gives you the program's exit code, once executed.

### Language detection

Bin-Build can be used seamlessly with C, C++ and Objective-C.

The script automatically detects the programming language, based on the file extension:

    C:           .c
    C++:         .cpp
    Objective-C: .m

Specific compiler settings will be used for each language.

### Language settings

Settings can be configured for each language, trough environment variables:

    C:           $BIN_BUILD_C
    C++:         $BIN_BUILD_CPP
    Objective-C: $BIN_BUILD_OBJC

Settings consist of the compiler arguments, separated by a `:` sign.  
For instance:

    export BIN_BUILD_C=-Wall:-Werror:-O2
    bin-build file.c

Settings can be set for the session, as in the previous example, or globally, in your `.bash_rc` or '.profile' file.

### Installation

Simply copy the script in a directory that's included in your executable path (like `/usr/local/bin/`), and make sure the executable flag is set.  
For instance:

    sudo cp bin-build.sh /usr/local/bin/bin-build
    sudo chmod 755 /usr/local/bin/bin-build

You'll then be able to call the script as a normal executable:

    svn-util ~/file.c

### Default settings

Here are the default settings, used for each language.

#### C

 * std=c99
 * Os
 * pedantic
 * Werror
 * Wall
 * Wextra
 * Wbad-function-cast
 * Wdeclaration-after-statement
 * Werror-implicit-function-declaration
 * Wmissing-braces
 * Wmissing-declarations
 * Wmissing-field-initializers
 * Wmissing-prototypes
 * Wnested-externs
 * Wold-style-definition
 * Wparentheses
 * Wreturn-type
 * Wshadow
 * Wsign-compare
 * Wstrict-prototypes
 * Wswitch
 * Wuninitialized
 * Wunknown-pragmas
 * Wunused-function
 * Wunused-label
 * Wunused-parameter
 * Wunused-value
 * Wunused-variable

#### C++

 * Os
 * pedantic
 * Werror
 * Wall
 * Wextra
 * Wmissing-braces
 * Wmissing-field-initializers
 * Wmissing-prototypes
 * Wparentheses
 * Wreturn-type
 * Wshadow
 * Wsign-compare
 * Wswitch
 * Wuninitialized
 * Wunknown-pragmas
 * Wunused-function
 * Wunused-label
 * Wunused-parameter
 * Wunused-value
 * Wunused-variable

#### Objective-C

 * framework Cocoa
 * std=c99
 * Os
 * pedantic
 * Werror
 * Wall
 * Wextra
 * Wbad-function-cast
 * Wdeclaration-after-statement
 * Werror-implicit-function-declaration
 * Wmissing-braces
 * Wmissing-declarations
 * Wmissing-field-initializers
 * Wmissing-prototypes
 * Wnested-externs
 * Wold-style-definition
 * Wparentheses
 * Wreturn-type
 * Wshadow
 * Wsign-compare
 * Wstrict-prototypes
 * Wstrict-selector-match
 * Wswitch
 * Wundeclared-selector
 * Wuninitialized
 * Wunknown-pragmas
 * Wunused-function
 * Wunused-label
 * Wunused-parameter
 * Wunused-value
 * Wunused-variable

License
-------

Bin-Build is released under the terms of the BSD license.

Repository Infos
----------------

    Owner:			Jean-David Gadina - XS-Labs
    Web:			www.xs-labs.com
    Blog:			www.noxeos.com
    Twitter:		@macmade
    GitHub:			github.com/macmade
    LinkedIn:		ch.linkedin.com/in/macmade/
    StackOverflow:	stackoverflow.com/users/182676/macmade

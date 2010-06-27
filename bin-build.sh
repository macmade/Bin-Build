#!/bin/bash

################################################################################
# Copyright (c) 2010, Jean-David Gadina <macmade@eosgarden.com>                #
# All rights reserved.                                                         #
#                                                                              #
# Redistribution and use in source and binary forms, with or without           #
# modification, are permitted provided that the following conditions are met:  #
#                                                                              #
#  -   Redistributions of source code must retain the above copyright notice,  #
#      this list of conditions and the following disclaimer.                   #
#  -   Redistributions in binary form must reproduce the above copyright       #
#      notice, this list of conditions and the following disclaimer in the     #
#      documentation and/or other materials provided with the distribution.    #
#  -   Neither the name of 'Jean-David Gadina' nor the names of its            #
#      contributors may be used to endorse or promote products derived from    #
#      this software without specific prior written permission.                #
#                                                                              #
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"  #
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE    #
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE   #
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE    #
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR          #
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF         #
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS     #
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN      #
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)      #
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE   #
# POSSIBILITY OF SUCH DAMAGE.                                                  #
################################################################################

# $Id$

BuildBin()
{
    EXEC=$0
    
    DIR=`dirname $1`
    ABS_PATH=`cd $DIR; pwd`
    FILE=`basename $1`
    IN="$ABS_PATH/$FILE"
    OUT="$ABS_PATH/${FILE%.*}"
    EXT=${FILE##*.}
    
    if [ $EXT == "c" ]; then
        
        LANG="C"
        CC=`which gcc`
        CC_ARGS="-std=c99:-Os:-pedantic:-Werror:-Wall:-Wextra:-Wbad-function-cast:-Wdeclaration-after-statement:-Werror-implicit-function-declaration:-Wmissing-braces:-Wmissing-declarations:-Wmissing-field-initializers:-Wmissing-prototypes:-Wnested-externs:-Wold-style-definition:-Wparentheses:-Wreturn-type:-Wshadow:-Wsign-compare:-Wstrict-prototypes:-Wswitch:-Wuninitialized:-Wunknown-pragmas:-Wunused-function:-Wunused-label:-Wunused-parameter:-Wunused-value:-Wunused-variable"
        CC_ARGS_OUT="-o $OUT $IN"
        
    elif [ $EXT == "cpp" ]; then
        
        LANG="C++"
        CC=`which g++`
        CC_ARGS="-Os:-pedantic:-Werror:-Wall:-Wextra:-Wmissing-braces:-Wmissing-field-initializers:-Wmissing-prototypes:-Wparentheses:-Wreturn-type:-Wshadow:-Wsign-compare:-Wswitch:-Wuninitialized:-Wunknown-pragmas:-Wunused-function:-Wunused-label:-Wunused-parameter:-Wunused-value:-Wunused-variable"
        CC_ARGS_OUT="-o $OUT $IN"
        
    elif [ $EXT == "m" ]; then
        
        LANG="Objective-C"
        CC=`which gcc`
        CC_ARGS="-framework Cocoa:-std=c99:-Os:-pedantic:-Werror:-Wall:-Wextra:-Wbad-function-cast:-Wdeclaration-after-statement:-Werror-implicit-function-declaration:-Wmissing-braces:-Wmissing-declarations:-Wmissing-field-initializers:-Wmissing-prototypes:-Wnested-externs:-Wold-style-definition:-Wparentheses:-Wreturn-type:-Wshadow:-Wsign-compare:-Wstrict-prototypes:-Wstrict-selector-match:-Wswitch:-Wundeclared-selector:-Wuninitialized:-Wunknown-pragmas:-Wunused-function:-Wunused-label:-Wunused-parameter:-Wunused-value:-Wunused-variable"
        CC_ARGS_OUT="-o $OUT $IN"
        
    else
        
        echo ""
        echo "$EXEC - error: unknown language ($EXT)."
        echo ""
        echo "Available languages are:"
        echo ""
        echo "    - C              .c"
        echo "    - C++            .cpp"
        echo "    - Objective-C    .m"
        echo ""
        exit
        
    fi
    
    IFS_OLD=$IFS
    IFS=":"
    read -ra CC_ARGS_A <<< "$CC_ARGS"
    IFS=$IFS_OLD
    
    echo ""
    echo "$EXEC: compiling file $1"
    echo ""
    echo "Settings:"
    echo ""
    echo "    - Language:       $LANG"
    echo "    - Compiler:       $CC"
    echo "    - Input file:     $IN"
    echo "    - Output file:    $OUT"
    echo ""
    echo "Compiler options:"
    echo ""
    
    for (( i = 0; i < ${#CC_ARGS_A[@]}; i += 3 )); do
        
        ARG1=${CC_ARGS_A[$i]}
        ARG2=${CC_ARGS_A[$i+1]}
        ARG3=${CC_ARGS_A[$i+2]}
        
        ARG1=${ARG1:1}
        ARG2=${ARG2:1}
        ARG3=${ARG3:1}
        
        let "PAD1_LENGTH=40 - ${#ARG1}"
        let "PAD2_LENGTH=40 - ${#ARG2}"
        
        PAD1=$( printf "%${PAD1_LENGTH}s" ' ' )
        PAD2=$( printf "%${PAD2_LENGTH}s" ' ' )
        
        PAD1=${PAD1//?/ }
        PAD2=${PAD2//?/ }
        
        if [ "$ARG1" ]; then ARG1="- $ARG1"; fi
        if [ "$ARG2" ]; then ARG2="- $ARG2"; fi
        if [ "$ARG3" ]; then ARG3="- $ARG3"; fi
        
        echo "   $ARG1 $PAD1 $ARG2 $PAD2 $ARG3"
        
    done
    
    echo ""
    echo "Compiling file..."
    echo ""
    
    if [ -f $OUT ]; then
        
        rm $OUT
        
    fi
    
    $CC $CC_ARGS_OUT ${CC_ARGS_A[*]}
    
    if [ ! -f $OUT ]; then
        
        echo "Compilation failed"
        echo ""
        exit
        
    fi
    
    echo "Compilation successfull"
    echo "Do you want to execute the produced binary now? [y/N]"
    
    read RUN
    
    if [ "$RUN" == "y" ] || [ "$RUN" == "Y" ] || [ "$RUN" == "yes" ] || [ "$RUN" == "Yes" ] || [ "$RUN" == "YES" ]; then
        
        echo ""
        echo "--------------------------------------------------------------------------------"
        echo "Executing $OUT"
        echo "--------------------------------------------------------------------------------"
        echo ""
        
        PROCESS=exec $OUT
        
        STATUS=$?
        
        echo ""
        echo "--------------------------------------------------------------------------------"
        echo "Process exit code: $STATUS"
        echo "--------------------------------------------------------------------------------"
        echo ""
        
    fi
}
    
if [ ! $1 ]; then
    
    echo ""
    echo "Usage: $EXEC source-file"
    echo ""
    exit
    
elif [ ! -f $1 ]; then
    
    echo ""
    echo "$EXEC - error: input file does not exist ($1)"
    echo ""
    exit
    
else
    
    BuildBin $1
    
fi

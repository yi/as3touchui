@echo off

:: 编译生成出的结果的路径
set BIN_RELEASE_PATH=%CD%\bin-release\

:: 编译生成的文件名
set BIN_RELEASE_FILENAME=as3touchui

:: 要插入的lib
set INCLUE_LIBS=%CD%\lib\

echo ===Clean old files
del "%BIN_RELEASE_PATH%*" /Q

echo ===Building release version...
compc  ^
 -output="%BIN_RELEASE_PATH%%BIN_RELEASE_FILENAME%.swc" ^
 -source-path "%CD%\src" ^
 -include-sources "%CD%\src" ^
 -include-libraries="%CD%\lib" ^
 -optimize ^
 -debug=false ^
 -omit-trace-statements=true 

:: -output "%BIN_RELEASE_PATH%\" 





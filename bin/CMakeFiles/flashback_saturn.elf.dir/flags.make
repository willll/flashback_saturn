# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.28

# compile ASM with /opt/saturn/toolchain/bin/sh-elf-as
# compile C with /opt/saturn/toolchain/bin/sh-elf-gcc
# compile CXX with /opt/saturn/toolchain/bin/sh-elf-g++
ASM_DEFINES = --defsym BYPASS_PROTECTION --defsym MODEL_S --defsym SYS_BIG_ENDIAN --defsym _SATURNPORT_ --defsym _SH

ASM_INCLUDES = -I/saturn/flashback_saturn/src -I/opt/saturn/sbl/segalib/include -I/opt/saturn/sgl/include

ASM_FLAGS = 

C_DEFINES = -DBYPASS_PROTECTION -DMODEL_S -DSYS_BIG_ENDIAN -D_SATURNPORT_ -D_SH

C_INCLUDES = -I/saturn/flashback_saturn/src -I/opt/saturn/sbl/segalib/include -I/opt/saturn/sgl/include

C_FLAGS =  -Wfatal-errors -fdiagnostics-color=always -fno-lto -Os -fno-rtti -fno-exceptions -nostdlib -m2 -c

CXX_DEFINES = -DBYPASS_PROTECTION -DMODEL_S -DSYS_BIG_ENDIAN -D_SATURNPORT_ -D_SH

CXX_INCLUDES = -I/saturn/flashback_saturn/src -I/opt/saturn/sbl/segalib/include -I/opt/saturn/sgl/include

CXX_FLAGS =  -fdiagnostics-color=always -fno-lto -Os -fno-rtti -fno-exceptions -nostdlib -m2 -c


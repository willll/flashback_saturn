cmake_minimum_required(VERSION 3.0)

SET(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_VERBOSE_MAKEFILE ON)

set( SATURN_COMMON $ENV{SATURN_COMMON} )
set( SATURN_CMAKE $ENV{SATURN_CMAKE} )
set( SATURN_ROOT $ENV{SATURN_ROOT} )

set( SEGALIB $ENV{SATURN_SBL}/segalib )
set( SEGASGL $ENV{SATURN_SGL} )

set( TARGET_NAME flashback_saturn )
set( TARGET_PATH flashback_saturn )

set( ENV{SATURN_CD} "${PROJECT_SOURCE_DIR}/saturnport/" )

project( ${TARGET_NAME} VERSION 0.1.9
                  DESCRIPTION "Du coup flashback"
                  LANGUAGES C CXX ASM)

set(as_flags )

set(c_flags
        -fpermissive
        -fno-lto 
        -Os
        -nostdlib 
        -m2
         )

set(cxx_flags
        -fno-lto 
        -Os
        -fno-rtti
        -fno-exceptions
        -m2
         )

set(SOURCES
    ${PROJECT_SOURCE_DIR}/src/gfs_wrap.cpp 
	${PROJECT_SOURCE_DIR}/src/collision.cpp 
	${PROJECT_SOURCE_DIR}/src/cutscene.cpp 
	${PROJECT_SOURCE_DIR}/src/file.cpp 
	${PROJECT_SOURCE_DIR}/src/game.cpp 
	${PROJECT_SOURCE_DIR}/src/graphics.cpp 
	${PROJECT_SOURCE_DIR}/src/main.cpp 
	${PROJECT_SOURCE_DIR}/src/menu.cpp 
	${PROJECT_SOURCE_DIR}/src/mixer.cpp 
	${PROJECT_SOURCE_DIR}/src/piege.cpp 
	${PROJECT_SOURCE_DIR}/src/unpack.cpp 
	${PROJECT_SOURCE_DIR}/src/resource.cpp 
	${PROJECT_SOURCE_DIR}/src/resource_mac.cpp 
	${PROJECT_SOURCE_DIR}/src/resource_aba.cpp 
	${PROJECT_SOURCE_DIR}/src/decode_mac.cpp 
	${PROJECT_SOURCE_DIR}/src/sfx_player.cpp 
	${PROJECT_SOURCE_DIR}/src/staticres.cpp 
	${PROJECT_SOURCE_DIR}/src/systemstub_sdl.cpp 
	${PROJECT_SOURCE_DIR}/src/util.cpp 
	${PROJECT_SOURCE_DIR}/src/video.cpp 
	${PROJECT_SOURCE_DIR}/src/sat_mem_checker.cpp 
	${PROJECT_SOURCE_DIR}/src/lz.cpp 
	${PROJECT_SOURCE_DIR}/src/cinit.cpp 
    ${PROJECT_SOURCE_DIR}/src/workarea.c
    ${PROJECT_SOURCE_DIR}/src/low.s
     )

set(CD_FILES
      0.bin )

add_compile_definitions(
                        MODEL_S
                        _SH
                        _SATURNPORT_
                        SYS_BIG_ENDIAN
                        BYPASS_PROTECTION
                         )

add_executable( ${TARGET_NAME}.elf ${SOURCES} )

target_include_directories(
        ${TARGET_NAME}.elf PUBLIC
        ${PROJECT_SOURCE_DIR}/src
        ${SEGALIB}/include
        ${SEGASGL}/include
        )

target_compile_options( ${TARGET_NAME}.elf PUBLIC $<$<COMPILE_LANGUAGE:CXX>:${cxx_flags}>
                                                $<$<COMPILE_LANGUAGE:C>:${c_flags}> )

target_link_options(
    ${TARGET_NAME}.elf PUBLIC
    "SHELL:-Xlinker -Map -Xlinker ${TARGET_NAME}.map"
    "SHELL:-Xlinker --strip-debug"
    "SHELL:-Xlinker -e -Xlinker ___Start"
    "SHELL:-Xlinker -fno-lto"
    "SHELL:-m2 -nostartfiles -fpermissive -fno-builtin"
    "SHELL:-T${PROJECT_SOURCE_DIR}/saturnport/saturn.lnk"
)

add_custom_target( run_${TARGET_NAME} ALL DEPENDS
                    ${TARGET_NAME}.elf
                    ${TARGET_NAME}.bin
                    IP.BIN )

add_custom_command( OUTPUT ${TARGET_NAME}.bin
                    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
                    COMMAND ${CMAKE_OBJCOPY}
                    ARGS -O binary ${TARGET_NAME}.elf ${TARGET_NAME}.bin )
        
add_custom_command( OUTPUT IP.BIN
                    WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}/saturnport/
                    COMMAND ${CMAKE_COMMAND} -E copy IP.BIN ${CMAKE_CURRENT_BINARY_DIR} )

target_link_libraries( ${TARGET_NAME}.elf PUBLIC stdc++ )                       
target_link_libraries( ${TARGET_NAME}.elf PUBLIC ${SEGASGL}/lib/libsgl.a )
target_link_libraries( ${TARGET_NAME}.elf PUBLIC ${PROJECT_SOURCE_DIR}/saturnport/sega_gfs2.a )
target_link_libraries( ${TARGET_NAME}.elf PUBLIC ${SEGALIB}/lib/sega_csh_sgl.a )
target_link_libraries( ${TARGET_NAME}.elf PUBLIC ${SEGALIB}/lib/sega_per_vbt.a )
target_link_libraries( ${TARGET_NAME}.elf PUBLIC ${SEGALIB}/lib/sega_mem.a )
target_link_libraries( ${TARGET_NAME}.elf PUBLIC ${SEGALIB}/lib/sega_dma.a )
target_link_libraries( ${TARGET_NAME}.elf PUBLIC ${SEGALIB}/lib/sega_snd.a )
target_link_libraries( ${TARGET_NAME}.elf PUBLIC ${SEGALIB}/lib/sega_sys.a )
target_link_libraries( ${TARGET_NAME}.elf PUBLIC ${SEGALIB}/lib/sega_cdc.a )
target_link_libraries( ${TARGET_NAME}.elf PUBLIC ${SEGALIB}/lib/sega_int.a )

include( ${SATURN_CMAKE}/install.cmake )
include( ${SATURN_CMAKE}/create_cd.cmake )

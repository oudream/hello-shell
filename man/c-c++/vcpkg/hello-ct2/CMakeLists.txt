cmake_minimum_required(VERSION 3.12...3.21 FATAL_ERROR)

project(hello-ct2 VERSION 1.0.1 LANGUAGES CXX C)

#cmake . -G "Visual Studio 10 2010" --build "C:\ddd\ccpp\gcl3\build\cmake" -B"C:\ddd\ccpp\gcl3\build\cmake\ccpro-vs2010"
#cmake . -G "Visual Studio 12 2013" --build "C:\ddd\ccpp\gcl3\build\cmake" -B"C:\ddd\ccpp\gcl3\build\cmake\ccpro-vs2013"
#cmake . -G "Visual Studio 14 2015" --build "C:\ddd\ccpp\gcl3\build\cmake" -B"C:\ddd\ccpp\gcl3\build\cmake\ccpro-vs2015"
#-DQT_QMAKE_EXECUTABLE:FILEPATH=F:/qt5.5.1mingw4.9/5.5/mingw492_32/bin/qmake.exe
#-DCMAKE_PREFIX_PATH:FILEPATH=F:/qt5.5.1mingw4.9/5.5/mingw492_32

### depend path
#CMAKE_CURRENT_SOURCE_DIR (current file path)
set(gs_project_path ${CMAKE_CURRENT_SOURCE_DIR})

message('PROJECT-PATH: ' ${gs_project_path})
message(${CMAKE_C_COMPILER_ID})
message(${CMAKE_CXX_COMPILER_ID})
#message(${CMAKE_PREFIX_PATH})

set(gs_project_build_path ${gs_project_path}/build)
set(gs_project_include_path ${gs_project_path}/include)
set(gs_project_lib_path ${gs_project_path}/lib)
set(gs_project_3rd_path ${gs_project_path}/3rd)
set(gs_project_gtest_path ${gs_project_path}/gtest)
set(gs_project_benchmark_path ${gs_project_path}/benchmark)
set(gs_project_hello_path ${gs_project_path}/hello)
set(gs_project_tools_path ${gs_project_path}/tools)
set(gs_project_tk_path ${gs_project_path}/tk)
set(gs_project_cyg_path ${gs_project_path}/cyg)
set(gs_project_cmake_path ${gs_project_build_path}/cmake)
set(gs_project_ccxx_path ${gs_project_3rd_path}/ccxx)
set(gs_project_deploy_path ${gs_project_path}/build/deploy)

if (U_DEPLOY_PATH)
    set(gs_project_deploy_path ${U_DEPLOY_PATH})
endif()

message("gs_project_deploy_path -" ${gs_project_deploy_path})

message("----------------------------------------------------------------------")

set(PAHO_MQTT_C_INCLUDE_DIRS ${gs_project_3rd_path}/paho.mqtt.c/src)

set_property(GLOBAL PROPERTY USE_FOLDERS ON)

### common
macro(mc_merge_file_path sDir sFileNames sOutFileNames)
    set(${sOutFileNames} "")
    #    message(${sFileNames})
    foreach (sFileName ${sFileNames})
        list(APPEND ${sOutFileNames} ${sDir}/${sFileName})
    endforeach ()
endmacro()

### lib processor dir
message("U_PROCESSOR - " ${U_PROCESSOR})
if (WIN32)
    if("${CMAKE_SIZEOF_VOID_P}" STREQUAL "4")
        set(gs_project_processor_lib_path ${gs_project_lib_path}/win32)
    else()
        set(gs_project_processor_lib_path ${gs_project_lib_path}/win64)
    endif()
else()
    if (U_PROCESSOR MATCHES "aarch64")
        if (U_OS_NAME MATCHES "openwrt")
            set(gs_project_processor_lib_path ${gs_project_lib_path}/aarch64/openwrt)
        else()
            set(gs_project_processor_lib_path ${gs_project_lib_path}/aarch64/linaro)
        endif()
    elseif(U_PROCESSOR MATCHES "armv7")
        set(gs_project_processor_lib_path ${gs_project_lib_path}/armv7/linaro)
    else()
        set(gs_project_processor_lib_path ${gs_project_lib_path}/amd64)
    endif()
endif()


#    message("--- --- ---" ${Qt5_DIR})
#    if (${Qt5_DIR})
#        list(APPEND CMAKE_PREFIX_PATH ${Qt5_DIR})
#    endif ()

SET(EXECUTABLE_OUTPUT_PATH "${gs_project_deploy_path}")
SET(LIBRARY_OUTPUT_PATH "${gs_project_deploy_path}")
SET(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG "${gs_project_deploy_path}")
SET(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE "${gs_project_deploy_path}")
SET(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG "${gs_project_deploy_path}")
SET(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE "${gs_project_deploy_path}")
SET(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG "${gs_project_deploy_path}")
SET(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE "${gs_project_deploy_path}")

add_subdirectory(./3rd)
add_subdirectory(./build/cmake)

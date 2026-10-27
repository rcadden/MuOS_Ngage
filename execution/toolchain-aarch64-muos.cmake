set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR aarch64)

set(CROSS_PREFIX "aarch64-linux-gnu")

set(CMAKE_C_COMPILER "${CROSS_PREFIX}-gcc")
set(CMAKE_CXX_COMPILER "${CROSS_PREFIX}-g++")
set(CMAKE_AR "${CROSS_PREFIX}-ar" CACHE FILEPATH "Archiver")
set(CMAKE_RANLIB "${CROSS_PREFIX}-ranlib" CACHE FILEPATH "Ranlib")
set(CMAKE_STRIP "${CROSS_PREFIX}-strip" CACHE FILEPATH "Strip")

# Target Allwinner H700 / Cortex-A53 (RG35XX H and standard muOS aarch64 handhelds)
set(CMAKE_C_FLAGS_INIT "-march=armv8-a+crc -mtune=cortex-a53")
set(CMAKE_CXX_FLAGS_INIT "-march=armv8-a+crc -mtune=cortex-a53")

set(CMAKE_FIND_ROOT_PATH "/usr/aarch64-linux-gnu" "/usr/lib/aarch64-linux-gnu")
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

set(ENV{PKG_CONFIG_PATH} "/usr/lib/aarch64-linux-gnu/pkgconfig:/usr/share/pkgconfig")
set(ENV{PKG_CONFIG_LIBDIR} "/usr/lib/aarch64-linux-gnu/pkgconfig:/usr/share/pkgconfig")

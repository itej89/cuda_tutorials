cmake_minimum_required(VERSION 3.10)


project(cuda_tutorials CUDA CXX C)  # enable cuda language
set(CMAKE_CUDA_COMPILER /usr/bin/nvcc)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    set(CMAKE_CUDA_FLAGS ${CMAKE_CUDA_FLAGS} "-g -G")  # enable cuda-gdb
endif()


add_subdirectory(01_vector_addition)
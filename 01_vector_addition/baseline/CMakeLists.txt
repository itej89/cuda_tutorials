find_package(CUDA REQUIRED)

# Specify the CUDA version
set(CUDA_NVCC_FLAGS "${CUDA_NVCC_FLAGS} -std=c++14")

# Add the executable
add_executable(vector_addition vectorAdd.cu)


# Link the CUDA runtime
target_link_libraries(vector_addition ${CUDA_LIBRARIES})
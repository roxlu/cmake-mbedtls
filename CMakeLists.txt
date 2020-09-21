# -----------------------------------------------------------------

cmake_minimum_required(VERSION 3.17)
project(externalprojectissue)
set(CMAKE_CXX_STANDARD 17)

# -----------------------------------------------------------------

set(base_dir ${CMAKE_CURRENT_LIST_DIR})
set(source_dir ${base_dir}/src)
include_directories(${source_dir})
  
# -----------------------------------------------------------------


set(mbedx_lib_file lib/libmbedx509.a)
set(mbedtls_lib_file lib/libmbedtls.a)
set(mbedcrypto_lib_file lib/libmbedcrypto.a)

include(ExternalProject)
ExternalProject_Add(
  mbedtls
  GIT_REPOSITORY https://github.com/ARMmbed/mbedtls.git
  UPDATE_COMMAND ""
  CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR> -DENABLE_TESTING=OFF  -DENABLE_PROGRAMS=OFF
  BUILD_BYPRODUCTS <INSTALL_DIR>/${mbedtls_lib_file} <INSTALL_DIR>/${mbedx_lib_file} <INSTALL_DIR>/${mbedcrypto_lib_file}
  BUILD_COMMAND ninja
  INSTALL_COMMAND ninja install
  STEP_TARGETS build install
  )

ExternalProject_Get_Property(mbedtls install_dir)
set(mbedtls_install_dir ${install_dir})
set(mbedtls_inc_dir ${mbedtls_install_dir}/include/)
set(mbedtls_lib_dir ${mbedtls_install_dir}/lib/)
include_directories(${mbedtls_inc_dir})

list(APPEND my_libs
  ${mbedtls_install_dir}/${mbedx_lib_file}
  ${mbedtls_install_dir}/${mbedtls_lib_file}
  ${mbedtls_install_dir}/${mbedcrypto_lib_file}
  )

list(APPEND my_deps mbedtls)

# -----------------------------------------------------------------

add_executable(test ${source_dir}/test-monkies.cpp)
add_dependencies(test ${my_deps} monkies)
install(TARGETS test DESTINATION bin)
target_link_libraries(test monkies)

# -----------------------------------------------------------------

list(APPEND sources
  ${source_dir}/Monkies.cpp
  )

add_library(monkies STATIC ${sources})
add_dependencies(monkies ${my_deps})

# -----------------------------------------------------------------

cmake_minimum_required(VERSION 3.27)
project(FreyaProjectTemplate) # @TODO: Change the name of your project from here

### FetchContent ###
############################################################
include(FetchContent)

# We need this to ensure the project is multi-threaded on Windows

if(WIN32)
  if(USE_STATIC_MSVC_RUNTIME_LIBRARY)
    set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
  endif()
endif()


# Setting the state of Freya

set(ALSOFT_EXAMPLES      OFF)
set(FREYA_BUILD_TESTBED OFF)

# Fetching Freya

FetchContent_Declare(
  freya
  GIT_REPOSITORY https://github.com/FrodoAlaska/Freya.git 
  GIT_TAG        4189ba6c3415c3f2343ccd81a4f36b89a5314076
)

FetchContent_MakeAvailable(freya)
############################################################

### Project variables ###
############################################################
set(PROJECT_SRC_DIR ${CMAKE_CURRENT_SOURCE_DIR}/src)
set(PROJECT_INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/src)
set(PROJECT_LIBS_DIR ${CMAKE_CURRENT_SOURCE_DIR}/libs)

set(PROJECT_INCLUDES 
  ${PROJECT_INCLUDE_DIR}
  ${PROJECT_LIBS_DIR}

  ${Tracy_SOURCE_DIR}/public
  ${freya_SOURCE_DIR}/freya/include
  ${freya_SOURCE_DIR}/libs
  ${glfw_SOURCE_DIR}/include
  ${glm_SOURCE_DIR}
  ${rmlui_SOURCE_DIR}/Include
)

include(cmake/variables.cmake)
############################################################

### CMake variables ###
############################################################
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
############################################################

### Project sources ###
############################################################
set(PROJECT_SOURCES
  # Core
  ${PROJECT_SRC_DIR}/app.cpp
  ${PROJECT_SRC_DIR}/main.cpp
)
############################################################

### Targets ###
############################################################
if(DIST_BUILD)
  add_definitions("-DDIST_BUILD")
  set(EXE_TYPE WIN32)
else()
  set(EXE_TYPE "")
endif()

add_executable(${PROJECT_NAME} ${EXE_TYPE} ${PROJECT_SOURCES})
############################################################

### Linking ###
############################################################
target_include_directories(${PROJECT_NAME} PUBLIC BEFORE ${PROJECT_INCLUDES})
target_link_libraries(${PROJECT_NAME} PUBLIC freya)

target_precompile_headers(${PROJECT_NAME} PRIVATE 
  "$<$<COMPILE_LANGUAGE:CXX>:${freya_SOURCE_DIR}/freya/include/freya.h>"
)
############################################################

### Compiling options ###
############################################################
target_compile_options(${PROJECT_NAME} PUBLIC ${PROJECT_BUILD_FLAGS})
target_compile_features(${PROJECT_NAME} PUBLIC cxx_std_20)
target_compile_definitions(${PROJECT_NAME} PUBLIC ${PROJECT_BUILD_DEFINITIONS})
############################################################

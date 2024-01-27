cmake_minimum_required(VERSION 3.8)
project(timing)


##############
## SETUP
##############

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -Wall -Wno-deprecated-declarations")

IF(NOT CMAKE_BUILD_TYPE)
  SET(CMAKE_BUILD_TYPE RelWithDebInfo)
ENDIF()

set(BUILD_SHARED_LIBS ON)


##############
## BUILD THE LIBRARY
##############

add_library(timing src/timing.cpp)
target_include_directories(timing PRIVATE include)

##############
## BUILD A TEST EXECUTABLE 
##############
add_executable(test_timing test/test_timing.cpp)
target_link_libraries(test_timing timing)
target_include_directories(test_timing PRIVATE include)


##############
## EXPORT THE LIBRARY
##############

install(FILES "${PROJECT_NAME}Config.cmake" "${PROJECT_NAME}ConfigVersion.cmake"
  DESTINATION "share/${PROJECT_NAME}/cmake")

install(TARGETS timing
  RUNTIME DESTINATION bin
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib)

install(DIRECTORY include/
  DESTINATION include/timing)




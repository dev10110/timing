# - Config file for the jps3d package
# It defines the following variables
#  timing_INCLUDE_DIRS - include directories for timing
#  timing_LIBRARIES    - libraries to link against

# Compute paths
get_filename_component(timing_CMAKE_DIR "${CMAKE_CURRENT_LIST_FILE}" PATH)
set(timing_INCLUDE_DIRS "${timing_CMAKE_DIR}/../../../include/")

set(timing_LIBRARIES
  "${timing_CMAKE_DIR}/../../../lib/libtiming.so"
  )

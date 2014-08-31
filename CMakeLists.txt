#============================================================================
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0.txt
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#============================================================================

cmake_minimum_required(VERSION 2.8.7)

project(Gutenberg)

# -- Dependencies --
# 1 - Qt
find_package(Qt4)
if(NOT QT4_FOUND)
  message(FATAL_ERROR "Error: Qt was not found on your system."
                      "You probably need to set the QT_QMAKE_EXECUTABLE variable.")
endif()
include(${QT_USE_FILE})

# -- Options --
option(GUTENBERG_LIBRARY_ONLY "Build only the Gutenberg library" OFF)
set(BUILD_SHARED_LIBS OFF)

# -- CMake variables
set(GUTENBERG_CMAKE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/CMake)
# Update CMake module path
set(CMAKE_MODULE_PATH
  ${GUTENBERG_CMAKE_DIR}
  ${CMAKE_MODULE_PATH}
  )

# -- Build the library/executable
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/Application)



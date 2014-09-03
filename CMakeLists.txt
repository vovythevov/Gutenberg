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

option(BUILD_TESTING "Build testing and demo applications" OFF)
if (${BUILD_TESTING} AND ${GUTENBERG_LIBRARY_ONLY})
  message(FATAL_ERROR "Testing need the executable. GUTENBERG_LIBRARY_ONLY must be OFF !")
endif()

# -- CMake variables
set(GUTENBERG_SOURCE_DIR ${CMAKE_SOURCE_DIR})
set(GUTENBERG_BUILD_DIR ${CMAKE_BINARY_DIR})
set(GUTENBERG_CMAKE_DIR ${CMAKE_SOURCE_DIR}/CMake)

# Update CMake module path
set(CMAKE_MODULE_PATH
  ${GUTENBERG_CMAKE_DIR}
  ${CMAKE_MODULE_PATH}
  )

# -- Build the library/executable
add_subdirectory(${GUTENBERG_SOURCE_DIR}/Application)

# -- Config Gutenber for external projects --
# Launcher
set(launcher_extension)
if (WIN32)
  set(launcher_extension "bat")
else()
  set(launcher_extension "sh")
endif()
set(GUTENBERG_LAUNCH_COMMAND "${GUTENBERG_BUILD_DIR}/GutenbergLauncher.${launcher_extension}")

get_filename_component(QT_BIN_DIR ${QT_QMAKE_EXECUTABLE} DIRECTORY)
get_property (GUTENBERG_BIN_DIR GLOBAL PROPERTY GUTENBERG_GUTENBERGER_DIR)
configure_file(
  ${GUTENBERG_CMAKE_DIR}/GutenbergLauncher.${launcher_extension}.in
  ${GUTENBERG_LAUNCH_COMMAND} @ONLY
  )

# Config file
configure_file(
  ${GUTENBERG_CMAKE_DIR}/GutenbergConfig.cmake.in
  ${GUTENBERG_BUILD_DIR}/GutenbergConfig.cmake @ONLY
  )

# -- Testing --
if(BUILD_TESTING)
  add_subdirectory(Demo)
endif()



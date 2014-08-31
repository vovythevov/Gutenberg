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

project(GutenbergLib)

# -- Build the library/executable
set(KIT_SRCS
  QFontIconParser.cpp
  QFontIconParser.h
  )

set(KIT_MOC_SRCS
  QFontIconParser.h
  )

QT4_WRAP_CPP(KIT_MOC_OUTFILES ${KIT_MOC_SRCS})

include_directories(
  ${CMAKE_CURRENT_BINARY_DIR}
  ${CMAKE_CURRENT_SOURCE_DIR}
  )

set(KIT_LIB_NAME GutenbergLib)
add_library(${KIT_LIB_NAME} ${KIT_SRCS} ${KIT_MOC_OUTFILES})
target_link_libraries(${KIT_LIB_NAME} ${QT_LIBRARIES})

if (NOT GUTENBERG_LIBRARY_ONLY)
  set(KIT_EXECUTABLE_NAME Gutenberger)
  add_executable(${KIT_EXECUTABLE_NAME} main.cpp)
  target_link_libraries(${KIT_EXECUTABLE_NAME} ${KIT_LIB_NAME})
endif()



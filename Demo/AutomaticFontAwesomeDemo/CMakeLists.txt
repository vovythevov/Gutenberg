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

project(AutomaticFontAwesomeDemo)

find_package(Qt4)
include(${QT_USE_FILE})

if (NOT GUTENBERG_SOURCE_DIR)
  find_package(Gutenberg)
endif()

# Use the Gutenberg macro to automatically download the font-awesome
include(GutenbergFontAwesomeMacro)
set(FONT_AWESOME_DIR "${CMAKE_CURRENT_BINARY_DIR}/FontAwesome")
GutenbergFontAwesomeMacro(DESTINATION_DIR ${FONT_AWESOME_DIR})

# -- Build the library/executable
include_directories(
  ${FONT_AWESOME_DIR}
  ${CMAKE_CURRENT_BINARY_DIR}
  ${CMAKE_CURRENT_SOURCE_DIR}
  )

QT4_ADD_RESOURCES(KIT_RESOURCES_RCC ${GUTENBERG_RESOURCE_FILE})
set(KIT_EXECUTABLE_NAME AutomaticFontAwesomeDemo)
add_executable(${KIT_EXECUTABLE_NAME} main.cpp)
target_link_libraries(${KIT_EXECUTABLE_NAME} ${QT_LIBRARIES})

GutenbergBuildFontMacro(
  TARGET ${KIT_EXECUTABLE_NAME}
  FONT_CSS_PATH ${GUTENBERG_CSS_FILE}
  FONT_HEADER_PATH ${CMAKE_CURRENT_BINARY_DIR}/GutenbergFontAwesomeTest.h
  )

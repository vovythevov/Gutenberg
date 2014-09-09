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
#
# Build the font header from the given font file.
#
# In details, it will add a custom command to build the header file before the
# target so the target can include the header file, build against it and use it.
#

macro(GutenbergBuildFontMacro)
  set(options)
  set(oneValueArgs
    TARGET
    FONT_CSS_PATH
    FONT_HEADER_PATH
  )
  set(multiValueArg)
  
  CMAKE_PARSE_ARGUMENTS(MY_GUTENBERG
    "${options}"
    "${oneValueArgs}"
    "${multiValueArgs}"
    ${ARGN}
    )

  set(NECESSARY_ARGS
    TARGET
    FONT_CSS_PATH
    FONT_HEADER_PATH
    )
  foreach(arg ${NECESSARY_ARGS})
    if (NOT ${MY_GUTENBERG_${ARGS}})
      message(FATAL_ERROR "${ARGS} must be given !")
    endif()
  endforeach()

  add_custom_command(
    TARGET ${MY_GUTENBERG_TARGET}
    PRE_BUILD
    COMMAND ${GUTENBERG_LAUNCH_COMMAND} Gutenberger ${MY_GUTENBERG_FONT_CSS_PATH} ${MY_GUTENBERG_FONT_HEADER_PATH}
    WORKING_DIRECTORY ${GUTENBERG_BUILD_DIR}
    )

  get_filename_component(FONT_DIR ${MY_GUTENBERG_FONT_HEADER_PATH} DIRECTORY)
  include_directories(${FONT_DIR})

endmacro()

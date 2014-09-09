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
# Configure the downloaded font and create the necessary variable for using it.
#

macro(GutenbergConfigureDownloadedFontMacro)
  set(options)
  set(oneValueArgs
      DESTINATION_DIR
      CSS_FILE
      FONT_FILE
   )

  set(multiValueArg)

  CMAKE_PARSE_ARGUMENTS(MY_GUTENBERG
    "${options}"
    "${oneValueArgs}"
    "${multiValueArgs}"
    ${ARGN}
    )

  set(NECESSARY_ARGS
    DESTINATION_DIR
    CSS_FILE
    FONT_FILE
    )
  foreach(arg ${NECESSARY_ARGS})
    if (NOT ${MY_GUTENBERG_${ARGS}})
      message(FATAL_ERROR "${ARGS} must be given !")
    endif()
  endforeach()

  set(GUTENBERG_CSS_FILE "${MY_GUTENBERG_CSS_FILE}")
  set(GUTENBERG_FONT_FILE "${MY_GUTENBERG_FONT_FILE}")

  if (NOT MY_GUTENBERG_CSS_FILE_ALIAS)
    set(MY_GUTENBERG_CSS_FILE_ALIAS "Gutenberg.css")
  endif ()
  if (NOT MY_GUTENBERG_FONT_FILE_ALIAS)
    set(MY_GUTENBERG_FONT_FILE_ALIAS "Gutenberg.ttf")
  endif()

  configure_file(
    ${GUTENBERG_CMAKE_DIR}/GutenbergResource.qrc.in
    ${MY_GUTENBERG_DESTINATION_DIR}/GutenbergResource.qrc
    )

  configure_file(
    ${GUTENBERG_CMAKE_DIR}/GutenbergResource.qrc.in
    ${MY_GUTENBERG_DESTINATION_DIR}/GutenbergResource.qrc
    )

  set(GUTENBERG_RESOURCE_FILE ${MY_GUTENBERG_DESTINATION_DIR}/GutenbergResource.qrc)

endmacro()

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
# Download the font awesome and create the necessary variable for using it.
# For an example see Demo/AutomaticFontAwesomeDemo.
#
# The macro inputs are:
# DESTINATION_DIR: Directory where the font awesome will be downloaded
#
# The options are:
# CSS_FILE_ALIAS: file path for the css file used in the resource file. Default
# is font-awesome.css
# FONT_FILE_ALIAS: file path for the font file used in the resource file.
# Default is fontawesome-webfont.ttf
# FONT_AWESOME_VERSION: String version used for font awesome. Default is "4.2.0".
# URL: String of the URL to download font-awesome. Default is
# fortawesome.github.io/Font-Awesome/assets/font-awesome-${MY_GUTENBERG_FONT_AWESOME_VERSION}.zip
# ZIP_FILE: Path to the font awesome zip file. If no ZIP_FILE is given, font
# awesome will be automatically downloaded from the given (or not) URL.
#
# This macro will define the following variables:
# GUTENBERG_FONT_AWESOME_DIR: Path to the unpacked font awesome dir
# GUTENBERG_CSS_FILE: Path to the font-awesome css file
# GUTENBERG_FONT_FILE: Path to the font-awesome font (.ttf) file
# GUTENBERG_RESOURCE_FILE: Path to the customized resource file for you application
#

macro(GutenbergFontAwesomeMacro)
  set(options)
  set(oneValueArgs
      DESTINATION_DIR

      # Optionnal args:
      CSS_FILE_ALIAS
      FONT_FILE_ALIAS
      FONT_AWESOME_VERSION
      URL
      ZIP_FILE
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
    )
  foreach(arg ${NECESSARY_ARGS})
    if (NOT ${MY_GUTENBERG_${ARGS}})
      message(FATAL_ERROR "${ARGS} must be given !")
    endif()
  endforeach()

  if (NOT MY_GUTENBERG_FONT_AWESOME_VERSION)
    set(MY_GUTENBERG_FONT_AWESOME_VERSION "4.2.0")
  endif()

  if (NOT MY_GUTENBERG_CUSTOM_URL)
    set(MY_GUTENBERG_CUSTOM_URL "fortawesome.github.io/Font-Awesome/assets/font-awesome-${MY_GUTENBERG_FONT_AWESOME_VERSION}.zip")
  endif()

  if (NOT MY_GUTENBERG_ZIP_FILE)
    set(MY_GUTENBERG_ZIP_FILE "${MY_GUTENBERG_DESTINATION_DIR}/FontAwesome.zip")
    file(DOWNLOAD ${MY_GUTENBERG_CUSTOM_URL} ${MY_GUTENBERG_ZIP_FILE})

    # Check for download error
    list(GET STATUS 0 ERROR_CODE)
    if(ERROR_CODE)
      file(REMOVE ${MY_GUTENBERG_ZIP_FILE})
      message(FATAL_ERROR "Failed to download file !")
    endif()
  endif()

  set(GUTENBERG_FONT_AWESOME_DIR "${MY_GUTENBERG_DESTINATION_DIR}/FontAwesome")
  execute_process(
    COMMAND ${CMAKE_COMMAND} -E tar xzf ${MY_GUTENBERG_ZIP_FILE}
    OUTPUT ${GUTENBERG_FONT_AWESOME_DIR}
    DEPENDS ${MY_GUTENBERG_ZIP_FILE}
    WORKING_DIRECTORY ${MY_GUTENBERG_DESTINATION_DIR}
    RESULT_VARIABLE ERROR_CODE
    )
  if(ERROR_CODE)
    file(REMOVE ${GUTENBERG_FONT_AWESOME_DIR})
    message(FATAL_ERROR "Failed to unpack zip file !")
  endif()

  include(GutenbergConfigureDownloadedFontMacro)
  GutenbergConfigureDownloadedFontMacro(
    DESTINATION_DIR ${MY_GUTENBERG_DESTINATION_DIR}
    CSS_FILE "${MY_GUTENBERG_DESTINATION_DIR}/font-awesome-${MY_GUTENBERG_FONT_AWESOME_VERSION}/css/font-awesome.css"
    FONT_FILE "${MY_GUTENBERG_DESTINATION_DIR}/font-awesome-${MY_GUTENBERG_FONT_AWESOME_VERSION}/fonts/fontawesome-webfont.ttf"
    )

endmacro()

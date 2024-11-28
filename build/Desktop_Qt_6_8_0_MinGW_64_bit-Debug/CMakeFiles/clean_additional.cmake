# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles\\appgallery-application_autogen.dir\\AutogenUsed.txt"
  "CMakeFiles\\appgallery-application_autogen.dir\\ParseCache.txt"
  "appgallery-application_autogen"
  )
endif()

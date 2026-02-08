if(WIN32)
  set(CMAKE_CXX_FLAGS_DEBUG   ${FREYA_DEBUG_BUILD_FLAGS})
  set(CMAKE_CXX_FLAGS_RELEASE ${FREYA_RELEASE_BUILD_FLAGS})
  
  set(PROJECT_BUILD_DEFINITIONS 
    "$<$<CONFIG:Debug>:DEBUG; _DEBUG>$<$<CONFIG:Release>:NDEBUG _NDEBUG>"
  )
elseif(LINUX)
  # Debug builds 
  if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    set(BUILD_FLAGS
      "-Wall"
      "-g"
    )
    set(BUILD_DEFS 
      "DEBUG"
      "_DEBUG"
    )
  # Release builds
  elseif(CMAKE_BUILD_TYPE STREQUAL "Release")
    set(BUILD_FLAGS
      "-w"
      "-O3"
      "-s"
    )
    set(BUILD_DEFS 
      "NDEBUG"
      "_NDEBUG"
    )
  endif()
  
  set(PROJECT_BUILD_FLAGS ${BUILD_FLAGS})
  set(PROJECT_BUILD_DEFINITIONS ${BUILD_DEFS})
endif()

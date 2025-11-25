# PDFium Package Configuration for CMake
#
# To use PDFium in your CMake project:
#
#   1. set the environment variable PDFium_DIR to the folder containing this file.
#   2. in your CMakeLists.txt, add
#       find_package(PDFium)
#   3. then link your executable with PDFium
#       target_link_libraries(my_exe pdfium_core)  # 注意：这里也变了

include(FindPackageHandleStandardArgs)

find_path(PDFium_INCLUDE_DIR
    NAMES "fpdfview.h"
    PATHS "${CMAKE_CURRENT_LIST_DIR}"
    PATH_SUFFIXES "include"
)

set(PDFium_VERSION "#VERSION#")

if(WIN32)
  find_file(PDFium_LIBRARY
        NAMES "pdfium_core.dll"  # 修改为新的库名
        PATHS "${CMAKE_CURRENT_LIST_DIR}"
        PATH_SUFFIXES "bin")

  find_file(PDFium_IMPLIB
        NAMES "pdfium_core.dll.lib"  # 修改为新的导入库名
        PATHS "${CMAKE_CURRENT_LIST_DIR}"
        PATH_SUFFIXES "lib")

  add_library(pdfium_core SHARED IMPORTED)  # 目标名称也改为 pdfium_core
  set_target_properties(pdfium_core
    PROPERTIES
    IMPORTED_LOCATION             "${PDFium_LIBRARY}"
    IMPORTED_IMPLIB               "${PDFium_IMPLIB}"
    INTERFACE_INCLUDE_DIRECTORIES "${PDFium_INCLUDE_DIR};${PDFium_INCLUDE_DIR}/cpp"
  )

  find_package_handle_standard_args(PDFium
    REQUIRED_VARS PDFium_LIBRARY PDFium_IMPLIB PDFium_INCLUDE_DIR
    VERSION_VAR PDFium_VERSION
  )
else()
  find_library(PDFium_LIBRARY
        NAMES "pdfium_core"  # 修改为新的库名
        PATHS "${CMAKE_CURRENT_LIST_DIR}"
        PATH_SUFFIXES "lib")

  add_library(pdfium_core SHARED IMPORTED)  # 目标名称也改为 pdfium_core
  set_target_properties(pdfium_core
    PROPERTIES
    IMPORTED_LOCATION             "${PDFium_LIBRARY}"
    INTERFACE_INCLUDE_DIRECTORIES "${PDFium_INCLUDE_DIR};${PDFium_INCLUDE_DIR}/cpp"
  )

  find_package_handle_standard_args(PDFium
    REQUIRED_VARS PDFium_LIBRARY PDFium_INCLUDE_DIR
    VERSION_VAR PDFium_VERSION
  )
endif()


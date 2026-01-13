
# get libcxx install directories
#
# usage:
# get_libcxx_install_dirs(library_dir_var module_manifest_dir_var)
#
# determine the path to install libc++ (usually LIBCXX_INSTALL_INCLUDE_TARGET_DIR)
# and libc++'s modules.c++.json (usually LIBCXX_MODULES_MANIFEST_INSTALL_DIR)
#
# This logic was broken out of libcxx/CMakeLists.txt as both libcxx and clang's
# driver.cpp need to know at least the latter value.
#
# If named variables are already set, thus function will NOT overwrite them,
# allowing user preference to take precedence.

function(get_libcxx_install_dirs lib_dir_var manifest_dir_var)
  set(LIBDIR_SUFFIX "${LLVM_LIBDIR_SUFFIX}")

  if(NOT DEFINED ${lib_dir_var} OR "${${lib_dir_var}}" STREQUAL "")
    if(LLVM_ENABLE_PER_TARGET_RUNTIME_DIR AND NOT APPLE)
      set(TARGET_SUBDIR ${LLVM_DEFAULT_TARGET_TRIPLE})
      if(LIBDIR_SUBDIR)
        string(APPEND TARGET_SUBDIR /${LIBDIR_SUBDIR})
      endif()
      set(ret_dir lib${LLVM_LIBDIR_SUFFIX}/${TARGET_SUBDIR})
    else()
      set(ret_dir lib${LIBDIR_SUFFIX})
    endif()

    # lib_dir_var is not already set - set it now
    set(${lib_dir_var} ${ret_dir} PARENT_SCOPE)
  else()
    # libdir was already explicity set. Grab that value, which might be
    # required for the manifest dir.
    set(ret_dir "${${lib_dir_var}}") 
  endif()

  # ret_dir now contains the lib directory. 
  # If the manifest dir is not explicitly set, set it to the same
  if(NOT DEFINED ${manifest_dir_var} OR "${${manifest_dir_var}}" STREQUAL "")
    set(${manifest_dir_var} ${ret_dir} PARENT_SCOPE)
  endif()

  # message(STATUS "get_libcxx_install_dirs() RET ${${lib_dir_var}} ${${manifest_dir_var}}")
endfunction()


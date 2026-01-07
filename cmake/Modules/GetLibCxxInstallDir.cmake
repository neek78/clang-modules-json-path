
# 
function(_maybe_set val out_var)
endfunction()

function(get_libcxx_install_dirs libdir_var manifestdir_var)
# message(FATAL_ERROR " XXXXXXXXXXXXXXXXXXXX die XXXXXXXXXXXXXXXXXXX")

  message(STATUS "UUU ${LLVM_LIBDIR_SUFFIX} ${LIBDIR_SUFFIX}")
  set(LIBDIR_SUFFIX "${LLVM_LIBDIR_SUFFIX}")

  if(LLVM_ENABLE_PER_TARGET_RUNTIME_DIR AND NOT APPLE)
    set(TARGET_SUBDIR ${LLVM_DEFAULT_TARGET_TRIPLE})
    if(LIBDIR_SUBDIR)
      string(APPEND TARGET_SUBDIR /${LIBDIR_SUBDIR})
    endif()
    set(ret_dir lib${LLVM_LIBDIR_SUFFIX}/${TARGET_SUBDIR})
  else()
    set(ret_dir lib${LIBDIR_SUFFIX})
  endif()

  if(NOT DEFINED ${manifestdir_var} OR "${${manifestdir_var}}" STREQUAL "")
    message(STATUS "setting ${manifestdir_var} to same value")
    set(${manifestdir_var} ${ret_dir} PARENT_SCOPE)
  else()
    message(STATUS "${manifestdir_var} explicitly set to ${${manifestdir_var}}")
  endif()
  
  set(${libdir_var} ${ret_dir} PARENT_SCOPE)
  message(STATUS "get_libcxx_install_dirs() RET ${libdir_var} ${manifestdir_var}")
endfunction()


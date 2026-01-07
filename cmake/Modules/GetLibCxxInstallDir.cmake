
# 
function(_maybe_set val out_var)
  if(NOT DEFINED ${out_var} OR "${${out_var}}" STREQUAL "")
    message(STATUS "_maybe_set(): setting ${out_var} to ${val}")
    set(${out_var} ${val} PARENT_SCOPE)
  else()
    message(STATUS "_maybe_set(): ${out_var} already explicitly set to ${${out_var}}")
  endif()
endfunction()

function(get_libcxx_install_dirs lib_dir_var manifest_dir_var)
# message(FATAL_ERROR " XXXXXXXXXXXXXXXXXXXX die XXXXXXXXXXXXXXXXXXX")

  message(STATUS "UUU ${LLVM_LIBDIR_SUFFIX} ${LIBDIR_SUFFIX}")
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
  else()
    # libdir was already explicity set. Grab that value, which might be required for
    # the manifest dir.
    set(ret_dir "${${lib_dir_var}}") 
  endif()

  _maybe_set(${ret_dir} ${lib_dir_var})
  _maybe_set(${ret_dir} ${manifest_dir_var}) 

  message(STATUS "get_libcxx_install_dirs() RET ${lib_dir_var} ${manifest_dir_var}")
endfunction()


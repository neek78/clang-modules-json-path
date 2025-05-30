
function(get_libcxx_install_dir out_var)
  #FIXME: don't overwrite if already set
  # if(DEFINED CLANG_RESOURCE_DIR AND NOT CLANG_RESOURCE_DIR STREQUAL "")

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

  set(${out_var} ${ret_dir} PARENT_SCOPE)
  message(STATUS "get_libcxx_install_dir() RET ${out_var}  - ${ret_dir}")
endfunction()

function(get_libcxx_modules_manifest_install_dir out)
  get_libcxx_install_dir(ret)
  message(STATUS "get_libcxx_modules_manifest_install_dir() - ${ret}")
  set(${out} ${ret} PARENT_SCOPE)
endfunction()


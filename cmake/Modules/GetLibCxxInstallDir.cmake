
function(get_libcxx_install_dir out_var)
  #FIXME: don't overwrite if already set
  message(STATUS "UUU ${LLVM_LIBDIR_SUFFIX}")
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
endfunction()

function(get_libcxx_modules_manifest_install_dir out)
  get_libcxx_install_dir(ret)
  set(${out} ${ret} PARENT_SCOPE)
endfunction()


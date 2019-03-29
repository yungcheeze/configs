here=$(pwd)
echo "((nil .
  ((cmake-ide-project-dir . \"$here/\")
   (cmake-ide-build-dir . \"$here/cmake-ide-build\")
   (cmake-ide-cmake-opts . \"-DCMAKE_BUILD_TYPE=Debug\")
   (helm-make-build-dir . \"cmake-ide-build\")
   (helm-make-arguments . \"-j4\")
   (helm-ctest-dir . \"$here/build/cmake-ide-build\")
   (gtest-target-dir . \"$here/OUT/bin/\")
  )))" >> .dir-locals.el

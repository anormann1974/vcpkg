# Common Ambient Variables:
#   CURRENT_BUILDTREES_DIR    = ${VCPKG_ROOT_DIR}\buildtrees\${PORT}
#   CURRENT_PACKAGES_DIR      = ${VCPKG_ROOT_DIR}\packages\${PORT}_${TARGET_TRIPLET}
#   CURRENT_PORT_DIR          = ${VCPKG_ROOT_DIR}\ports\${PORT}
#   PORT                      = current port name (zlib, etc)
#   TARGET_TRIPLET            = current triplet (x86-windows, x64-windows-static, etc)
#   VCPKG_CRT_LINKAGE         = C runtime linkage type (static, dynamic)
#   VCPKG_LIBRARY_LINKAGE     = target library linkage type (static, dynamic)
#   VCPKG_ROOT_DIR            = <C:\path\to\current\vcpkg>
#   VCPKG_TARGET_ARCHITECTURE = target architecture (x64, x86, arm)
#

include(vcpkg_common_functions)

vcpkg_from_github(
	OUT_SOURCE_PATH SOURCE_PATH
	REPO vsg-dev/VulkanSceneGraph
    REF master
	SHA512 49a5d1f8ad4d0f904896d64bbc42fcec36490257175c0a04db1357ebed60d7b8a03d435016624af9da5cb737ad96f393ef71f4372f3c8d2fafbecd0d39cf3bb3
	HEAD_REF master
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    # PREFER_NINJA # Disable this option if project cannot be built with Ninja
    OPTIONS
    # OPTIONS_RELEASE -DOPTIMIZE=1
    # OPTIONS_DEBUG -DDEBUGGABLE=1
)

vcpkg_install_cmake()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/lib/cmake)

file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/share/vsg/cmake)
file(GLOB VSG_CMAKE ${CURRENT_PACKAGES_DIR}/lib/cmake/vsg/*.cmake)
file(COPY ${VSG_CMAKE} DESTINATION ${CURRENT_PACKAGES_DIR}/share/vsg/cmake)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/lib/cmake)

#file(RENAME ${CURRENT_PACKAGES_DIR}/lib/cmake ${CURRENT_PACKAGES_DIR}/share/vsg/cmake)


# Handle copyright
# file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/vsg RENAME copyright)
# Handle copyright
file(COPY ${SOURCE_PATH}/LICENSE.md DESTINATION ${CURRENT_PACKAGES_DIR}/share/vsg)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/vsg/LICENSE.md ${CURRENT_PACKAGES_DIR}/share/vsg/copyright)


# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME vsg)

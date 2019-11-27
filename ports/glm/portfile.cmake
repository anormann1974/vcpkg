include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO g-truc/glm
    REF 0.9.9.6
    SHA512 1bc8fc1da21e19f95d4a24259993c7932db328fdd2d0db68dbf60c07f372e19003a8df094fb4e153bb7f50df584c17cf0a540d3d3c38b7a287f3b55314ec2d70
    HEAD_REF master
)

file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
)

vcpkg_install_cmake()
vcpkg_fixup_cmake_targets()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug)

# Put the license file where vcpkg expects it
file(COPY ${SOURCE_PATH}/manual.md DESTINATION ${CURRENT_PACKAGES_DIR}/share/glm/)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/glm/manual.md ${CURRENT_PACKAGES_DIR}/share/glm/copyright)

include(vcpkg_common_functions)

vcpkg_from_github(
	OUT_SOURCE_PATH SOURCE_PATH
	REPO jklimke/libcitygml
	REF v2.0.9
	SHA512 1980f270d39a646bee8c3dac337f7407421382f111a813afb9526d3481a8a37391848e5fcc2c530945c22d953d1547c6720677dc6a60613bed56b41f5308ed4d
	HEAD_REF master
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
		-DLIBCITYGML_OSGPLUGIN=OFF
		-DLIBCITYGML_TESTS=OFF
		-DLIBCITYGML_USE_GDAL=ON
    # OPTIONS_RELEASE -DOPTIMIZE=1
    # OPTIONS_DEBUG -DDEBUGGABLE=1
)

vcpkg_install_cmake()

# Remove debug include directory
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

# Handle copyright
file(COPY ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/libcitygml)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/libcitygml/LICENSE ${CURRENT_PACKAGES_DIR}/share/libcitygml/copyright)

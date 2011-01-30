#!/bin/tcsh

# Copy shared resource bundle

cp -Rfv ${SRCROOT}/${LIBRARY_RESOURCE_BUNDLE_PATH}/${LIBRARY_RESOURCE_BUNDLE_NAME} ${BUILD_SHARED_BUNDLES_PATH}

# Recursively find and remove .svn, .gitignore, .DS_Store, etc from the deployed resource bundle path.
# (Xcode removes *most* of these…)

find ${BUILD_SHARED_BUNDLES_PATH}/${LIBRARY_RESOURCE_BUNDLE_NAME} -type d -name .svn -exec rm -rf {} \;
find ${BUILD_SHARED_BUNDLES_PATH}/${LIBRARY_RESOURCE_BUNDLE_NAME} -type d -name .svn -exec rm -rf {} \;
find ${BUILD_SHARED_BUNDLES_PATH}/${LIBRARY_RESOURCE_BUNDLE_NAME} -type d -name .gitignore -exec rm -rf {} \;
#find ${BUILD_SHARED_BUNDLES_PATH}/${LIBRARY_RESOURCE_BUNDLE_NAME} -type f -name .DS_Store -exec rm -rf {} \;


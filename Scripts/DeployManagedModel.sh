#!/bin/tcsh

# Create 'Models' directory if it does not exist.

mkdir -p ${BUILD_SHARED_BUNDLES_PATH}/${LIBRARY_RESOURCE_BUNDLE_NAME}/Models

# Copy named Managed Model of type (.mom or .momd) to Models directory of the Libraries Resource Bundle.

cp -RfX ${BUILT_PRODUCTS_DIR}/${LIBRARY_MOM_NAME}.${LIBRARY_MOM_TYPE} ${BUILD_SHARED_BUNDLES_PATH}/${LIBRARY_RESOURCE_BUNDLE_NAME}/Models

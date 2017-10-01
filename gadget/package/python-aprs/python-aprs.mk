################################################################################
#
# python-aprs
#
############################################################################

PYTHON_APRS_VERSION = 3eea3ad38fdad0ce2234c72d67e3cbf3dce0de4f
PYTHON_APRS_SOURCE = APRS_$(PYTHON_APRS_VERSION).tar.gz
PYTHON_APRS_SITE = http://github.com/ampledata/aprs
PYTHON_APRS_SITE_METHOD = git
PYTHON_APRS_LICENSE = APACHE
PYTHON_APRS_LICENSE_FILES = LICENSE
PYTHON_APRS_DEPENDENCIES = python-nose python-httpretty python-coverage
PYTHON_APRS_SETUP_TYPE = setuptools

$(eval $(python-package))

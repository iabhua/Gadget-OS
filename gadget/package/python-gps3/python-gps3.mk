################################################################################
#
# python-gps3
#
############################################################################

PYTHON_GPS3_VERSION = b55a13a7984fc7f06a1ec4734549884be724a51e
PYTHON_GPS3_SOURCE = PYTHON_GPS_$(PYTHON_GPS3_VERSION).tar.gz
PYTHON_GPS3_SITE = https://github.com/wadda/gps3
PYTHON_GPS3_SITE_METHOD = git
PYTHON_GPS3_LICENSE = MIT
PYTHON_GPS3_LICENSE_FILES = LICENSE
PYTHON_GPS3_DEPENDENCIES = 
PYTHON_GPS3_SETUP_TYPE = setuptools

$(eval $(python-package))

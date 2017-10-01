################################################################################
#
# python-kiss
#
############################################################################

PYTHON_KISS_VERSION = 31ecfb4482e9f013a4a5120d7a9a32f6351bef8d
PYTHON_KISS_SOURCE = KISS_$(PYTHON_KISS_VERSION).tar.gz
PYTHON_KISS_SITE = http://github.com/ampledata/kiss
PYTHON_KISS_SITE_METHOD = git
PYTHON_KISS_LICENSE = APACHE
PYTHON_KISS_LICENSE_FILES = LICENSE
PYTHON_KISS_DEPENDENCIES = 
PYTHON_KISS_SETUP_TYPE = setuptools

$(eval $(python-package))

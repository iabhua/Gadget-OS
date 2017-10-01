################################################################################
#
# python-dummyserial
#
############################################################################

PYTHON_DUMMYSERIAL_VERSION = 2891ae086d256aaeb13c9d7296a75447c7ccb60d
PYTHON_DUMMYSERIAL_SOURCE = DUMMYSERIAL_$(PYTHON_DUMMYSERIAL_VERSION).tar.gz
PYTHON_DUMMYSERIAL_SITE = http://github.com/ampledata/dummyserial
PYTHON_DUMMYSERIAL_SITE_METHOD = git
PYTHON_DUMMYSERIAL_LICENSE = APACHE
PYTHON_DUMMYSERIAL_LICENSE_FILES = LICENSE
PYTHON_DUMMYSERIAL_DEPENDENCIES =
PYTHON_DUMMYSERIAL_SETUP_TYPE = setuptools

$(eval $(python-package))

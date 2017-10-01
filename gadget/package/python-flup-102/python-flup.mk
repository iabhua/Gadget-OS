################################################################################
#
# python-flup
#
############################################################################

PYTHON_FLUP_102_VERSION = 1.0.2
PYTHON_FLUP_102_SOURCE = flup-$(PYTHON_FLUP_102_VERSION).tar.gz
PYTHON_FLUP_102_SITE = https://pypi.python.org/packages/10/28/7f3a17c792fa224ef8624f504db44fcf803bd066466f808fcb6b7a8e65f4
PYTHON_FLUP_102_SITE_METHOD = https
PYTHON_FLUP_102_LICENSE = NONE
PYTHON_FLUP_102_LICENSE_FILES = README
PYTHON_FLUP_102_DEPENDENCIES =
PYTHON_FLUP_102_SETUP_TYPE = setuptools

$(eval $(python-package))

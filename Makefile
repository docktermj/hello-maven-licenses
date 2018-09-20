# PROGRAM_NAME is the name of the GIT repository.
# It should match <artifactId> in pom.xml
PROGRAM_NAME := $(shell basename `git rev-parse --show-toplevel`)

# -----------------------------------------------------------------------------
# The first "make" target runs as default.
# -----------------------------------------------------------------------------

.PHONY: default
default: help

# -----------------------------------------------------------------------------
# Local development
# -----------------------------------------------------------------------------

.PHONY: package
package:
	mvn package

.PHONY: run
run:
	mvn exec:java

# -----------------------------------------------------------------------------
# Utility targets
# -----------------------------------------------------------------------------

.PHONY: clean
clean:
	-mvn clean

.PHONY: help
help:
	@echo 'make commands for $(PROGRAM_NAME)-$(GIT_VERSION).jar'
	@echo '  "make package"             Build locally'
	@echo '  "make docker-package"      Build in a docker container'
	@echo '  "make run"                 Run the java program'
	@echo '  "make clean"               Delete generated artifacts'
	@echo ''
	@echo 'Git information:'
	@echo '   Branch: $(GIT_BRANCH)'
	@echo '      SHA: $(GIT_SHA)'	
	@echo '  Version: $(GIT_VERSION_LONG)'
	@echo ''
	@echo "List of make targets:"
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$' | xargs

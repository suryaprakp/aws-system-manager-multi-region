SHELL := /bin/bash
.SUFFIXES:
.DEFAULT_GOAL := default

include Makefile-terraform

SUBDIRS := envs/lab/ envs/prod/

.PHONY: env clobber $(SUBDIRS)

$(TOP_TARGETS): $(PROJECT_DIRS)

env: bin/terraform

clobber:
	$(RM) -rf bin/
	$(RM) -rf tmp/

$(SUBDIRS):
	$(MAKE) -C $@ $(MAKECMDGOALS)

clean: 
	$(RM) -rf bin/ tmp/ *.stamp

default: env
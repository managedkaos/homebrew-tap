RUBY ?= ruby
BREW ?= brew
FORMULA_FILES := $(wildcard Formula/*.rb)

help: ## Display available targets
	@awk 'BEGIN {FS = ":.*## "}; /^[a-zA-Z0-9_-]+:.*## / {printf "\033[36m%-28s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

lint: lint-syntax lint-style ## Lint all Homebrew formula files

lint-syntax: ## Check Ruby syntax in formula files
	@set -e; for file in $(FORMULA_FILES); do $(RUBY) -c "$$file"; done

lint-style: ## Check Homebrew formula style
	$(BREW) style $(FORMULA_FILES)

.PHONY: help lint lint-syntax lint-style

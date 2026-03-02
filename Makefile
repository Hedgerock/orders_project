CURRENT_PATH=docs/diagrams/c4
LIB_PATH=$(CURRENT_PATH)/lib

DIAGRAMS := $(wildcard $(CURRENT_PATH)/**/*.puml)
DIAGRAMS := $(filter-out $(LIB_PATH)/%,$(DIAGRAMS))

check-diagrams:
	java -jar tools/plantuml.jar -checkonly $(DIAGRAMS)

render-diagrams:
	java -jar tools/plantuml.jar -tsvg -o ../../rendered $(DIAGRAMS)

check-yaml:
	yamlling -d "{extends: default, rules: {line-length: disable}}" k8s/

check-k8s: check-yaml

check: check-diagrams check-k8s
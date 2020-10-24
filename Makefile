DIST_DIR = dist/
ARTIFACT_NAME = custom-control-tower-configuration.zip

all: clean build deploy

.PHONY: build
build: clean
	@mkdir $(DIST_DIR)
	@cp -r src/* $(DIST_DIR)
	@find dist/templates -name "*.yaml" -exec bash -c 'mv "$$1" "$${1%.yaml}".template' - '{}' \;
	cd $(DIST_DIR); zip -r $(ARTIFACT_NAME) .

.PHONY: deploy
deploy:
	aws s3 cp $(DIST_DIR)$(ARTIFACT_NAME) s3://$(ARTIFACT_NAME)

.PHONY: clean
clean:
	@rm -rf $(DIST_DIR)
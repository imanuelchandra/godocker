AUTHOR?=imanuelchandra
REPOSITORY?=godocker

.PHONY: build
build_godocker:
	docker build -t ${AUTHOR}/${REPOSITORY}:${GO_DOCKER_VERSION}  . \
			--build-arg A_GOLANG_VERSION=${GO_DOCKER_VERSION} \
			--progress=plain \
			--no-cache
	@echo
	@echo "Build finished. Docker image name: \"${AUTHOR}/${REPOSITORY}:${GO_DOCKER_VERSION}\"."

.PHONY: run
run_godocker:
	docker run -it --rm --privileged=True --init --net host \
			-v ./app:/app \
	        -v ./config:/config \
			-v ./data:/data \
			-v ./log:/log \
			-v ./scripts:/scripts \
			${AUTHOR}/${REPOSITORY}:${GO_DOCKER_VERSION} eth0
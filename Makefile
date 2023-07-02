BASEDIR  := ${CURDIR}
FRONTEND := ${BASEDIR}/frontend
BACKEND  := ${BASEDIR}/backend
STATIC   := ${BASEDIR}/static

.PHONY: backend-mod-verify
test-backend:
	cd ${BACKEND} && go mod verify

.PHONY: backend-vet
backend-vet:
	cd ${BACKEND} && go vet ./...

.PHONY: backend-test
backend-test:
	cd ${BACKEND} && go test -race ./...

.PHONY: backend-build
backend-build:
	cd ${BACKEND} && go build -v ./...

.PHONY: backend-run
backend-run:
	cd ${BACKEND} && \
	go run main.go

.PHONY: run-frontend
run-frontend:
	cd ${FRONTEND} && \
	node server.js

.PHONY: build-frontend
build-frontend:
	cd ${FRONTEND} && \
	docker buildx build --platform linux/amd64 -t welmoki/hello-world-frontend . && \
	docker push welmoki/hello-world-frontend && \
	cd ${FRONTEND}/k8s && \
	kubectl apply -f deployment.yaml && \
	kubectl apply -f service.yaml && \
	kubectl get pods && kubectl get services

.PHONY: build-backend
build-backend:
	cd ${BACKEND} && \
	docker buildx build --platform linux/amd64 -t welmoki/hello-world-backend .
	docker push welmoki/hello-world-backend && \
	cd ${BACKEND}/k8s && \
	kubectl apply -f deployment.yaml && \
	kubectl apply -f service.yaml && \
	kubectl get pods && kubectl get services
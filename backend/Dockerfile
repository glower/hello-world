############################
# STEP 1 build executable binary
############################
FROM golang:alpine AS builder

# Install git.
# Git is required for fetching the dependencies.
RUN apk update && apk add --no-cache git

# Use an official Go runtime as the base image
# FROM golang:1.19-alpine

# Set the working directory in the container
WORKDIR /app

# Copy the Go module files to the working directory
COPY go.mod go.sum ./

# Download and install the Go module dependencies
RUN go mod download

# Copy the entire project to the working directory
COPY . .

# Build the Go service
RUN GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o app .

############################
# STEP 2 build a small image
############################
FROM scratch

# Copy our static executable.
COPY --from=builder /app/app /app

# Expose the port that the application listens on
EXPOSE 8080

# Run the hello binary.
ENTRYPOINT ["/app"]
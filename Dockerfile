FROM golang

WORKDIR /usr/go

COPY . .

RUN apt-get update && apt install -y protobuf-compiler \
    && go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.28 \
    && go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.2

RUN go mod init github.com/italog/go-gRPC \
    && go mod tidy

RUN protoc --go_out=. --go-grpc_out=. proto/course_category.proto 
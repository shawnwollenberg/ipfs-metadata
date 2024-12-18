FROM golang:1.23-alpine AS build

WORKDIR /app

COPY go.mod ./
COPY *.go ./

RUN go mod tidy
RUN go build -o /ipfs_fetcher

## Using a smaller image to run our application
FROM scratch
WORKDIR /
COPY --from=build /ipfs_fetcher /ipfs_fetcher
EXPOSE 8080
ENTRYPOINT ["/ipfs_fetcher"]
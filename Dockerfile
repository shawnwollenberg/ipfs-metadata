# Build the image binary 
FROM golang:1.21-alpine AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

# Run the image binary in lightweight alpine
FROM alpine:latest  
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /app/main .

# Code is expecting the .env file and data( likely should be removed in production )
COPY .env .env
COPY data/ipfs_cids.csv data/ipfs_cids.csv

EXPOSE 8080
CMD ["./main"]
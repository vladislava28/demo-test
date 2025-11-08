FROM golang:1.24.2-alpine AS builder

WORKDIR /app

COPY ./gateway/main.go .

COPY ./go.mod .

RUN go mod tidy

RUN go build -o gateway

# STAGE 2

FROM alpine:3.22

WORKDIR /app

COPY --from=builder /app/gateway .

EXPOSE 8080

CMD ["/app/gateway"]
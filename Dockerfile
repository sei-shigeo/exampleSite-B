FROM golang:1.23.2 AS development

WORKDIR /app

COPY . .

RUN go mod download && go mod tidy

CMD ["go", "run", "."]

FROM golang:1.23.2 AS builder

WORKDIR /app

COPY . .
RUN go mod download && go mod verify

RUN CGO_ENABLED=0 GOOS=linux go build -o ./bin/main

FROM alpine:latest AS production


WORKDIR /

COPY --from=builder /app/bin/main ./main

CMD ["/main"]
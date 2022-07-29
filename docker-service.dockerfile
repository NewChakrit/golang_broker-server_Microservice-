# base go image
FROM golang:1.18-alpine

RUN mkdir /app

COPY . /app

WORKDIR /app

RUN CGO_ENABLED=0 go build -o brokerApp ./cmd/api

RUN chmod +x /app/brokerApp

# build a tiny docker image
FROM alpine:latest

RUN mkdie /app

COPY --from=builder /app/brokerApp /app

CMD [ "/app/brokerApp" ]
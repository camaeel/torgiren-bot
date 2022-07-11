FROM golang:1.18 AS build

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY * ./

RUN go build -o /discord-bot .

#########
FROM gcr.io/distroless/base-debian11

WORKDIR /

COPY --from=build /discord-bot /discord-bot

USER nonroot:nonroot

ENTRYPOINT ["/discord-bot"]

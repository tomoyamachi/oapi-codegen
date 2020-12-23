FROM golang:1.14-alpine AS builder

WORKDIR /go/src/github.com/deepmap/oapi-codegen
COPY . .
RUN CGO_ENABLED=0 go build -mod=vendor -o /codegen ${PWD}/cmd/oapi-codegen && chmod +x /codegen
COPY . /go/src/github.com/containous/traefik


FROM scratch
COPY --from=builder /codegen /codegen
ENTRYPOINT ["/codegen"]
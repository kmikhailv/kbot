FROM golang:1.19 as builder
ARG build_target=linux

WORKDIR /go/src/app
COPY . .
RUN make $build_target

FROM  scratch
WORKDIR /
COPY --from=builder /go/src/app/kbot .
COPY --from=alpine:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
ENTRYPOINT [ "./kbot" ]
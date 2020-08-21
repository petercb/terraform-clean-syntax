FROM golang:1.15 AS build

WORKDIR /go/src/app
ADD . /go/src/app
RUN go get -d -v ./...
RUN go build -o /go/bin/terraform-clean-syntax

FROM gcr.io/distroless/base AS runtime

COPY --from=build /go/bin/terraform-clean-syntax /
ENTRYPOINT ["/terraform-clean-syntax"]

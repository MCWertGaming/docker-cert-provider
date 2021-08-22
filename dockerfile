# set registry url's
# change if you want to use a custom registry
ARG REGISTRY_DOCKERHUB=docker.io
ARG REGISTRY_REDHAT=registry.access.redhat.com

FROM $REGISTRY_DOCKERHUB/alpine:latest as builder

# change to use with your own step-ca instance
ARG CA_URL
ARG CA_FINGERPRINT

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
    && apk add step-cli \
    && step ca root root_ca.crt --ca-url $CA_URL --fingerprint $CA_FINGERPRINT

FROM scratch
COPY --from=builder /root_ca.crt /root_ca.crt

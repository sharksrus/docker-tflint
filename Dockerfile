FROM alpine:3.13.4
LABEL Glen Stummer <glen@glen.dev>

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]
RUN apk add --no-cache --virtual .build-deps \
    zip~=3.0 \
    wget~=1.21.1-r1 \
    curl~=7.74.0 &&\
    curl -L "$(curl -Ls https://api.github.com/repos/terraform-linters/tflint/releases/latest | grep -o -E "https://.+?_linux_amd64.zip")" -o tflint.zip &&\
    unzip tflint.zip &&\
    rm tflint.zip &&\
    mv tflint /usr/local/bin/ &&\
    apk del --purge .build-deps

ENTRYPOINT ["/usr/local/bin/tflint"]
CMD ["tflint"]
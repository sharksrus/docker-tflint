FROM alpine:3.12.0
LABEL Glen Stummer <glen@glen.dev>

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]
RUN apk add --no-cache --virtual .build-deps \
    zip~=3.0 \
    wget~=1.20.3-r1 \
    curl~=7.69.1 &&\
    curl -L "$(curl -Ls https://api.github.com/repos/terraform-linters/tflint/releases/latest | grep -o -E "https://.+?_linux_amd64.zip")" -o tflint.zip &&\
    unzip tflint.zip &&\
    rm tflint.zip &&\
    mv tflint /usr/local/bin/ &&\
    apk del --purge .build-deps

ENTRYPOINT ["/usr/local/bin/tflint"]
CMD ["tflint"]
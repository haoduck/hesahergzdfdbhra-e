FROM alpine:latest

ADD sb.sh /sb.sh

RUN apk add --no-cache --virtual .build-deps ca-certificates curl bash \
 && chmod +x /sb.sh

EXPOSE 80
EXPOSE 8080

CMD /sb.sh
FROM alpine:latest

RUN apk update \
 && apk upgrade \
 && apk add --no-cache \
        ca-certificates \
 && update-ca-certificates \
 
 # Install postfix
 && apk add --no-cache \
    thttpd supervisor rsyslog \
 && (rm "/tmp/"* 2>/dev/null || true) && (rm -rf /var/cache/apk/* 2>/dev/null || true)

RUN ["mkdir", "/etc/thttpd"]
RUN ["mkdir", "/www"]

COPY supervisord.conf /etc/supervisord.conf
COPY rsyslog.conf /etc/rsyslog.conf
COPY thttpd.conf /etc/thttpd/thttpd.conf

RUN chown -R thttpd: /etc/thttpd && chown -R nobody: /www

CMD ["supervisord", "-c", "/etc/supervisord.conf"]

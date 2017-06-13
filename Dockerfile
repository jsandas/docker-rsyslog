FROM alpine

MAINTAINER Hedge  

RUN  apk add --update gnutls rsyslog rsyslog-tls \
  && rm -rf /var/cache/apk/*

EXPOSE 514/udp
EXPOSE 6514

# This isn't necessary if you plan to store everything on disk
# Uncomment if you was a docker volume created
# VOLUME [ "/var/log", "/etc/rsyslog.d" ]

# for some reason, the apk comes built with a v5
# config file. using this one for v8:

RUN adduser -S -h /var/spool/rsyslog syslog 

COPY ./etc/rsyslog.* /etc/

#USER syslog

ENTRYPOINT [ "rsyslogd", "-n" ]

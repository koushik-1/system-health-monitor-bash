FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
  bc curl coreutils procps net-tools \
  && apt-get clean

COPY system_health_check.sh /system_health_check.sh
COPY slack_alert.sh /slack_alert.sh

RUN chmod +x /system_health_check.sh /slack_alert.sh

CMD ["/system_health_check.sh"]

FROM ubuntu:22.04
USER root
RUN mkdir -p /opt/app
ADD weekly-uptime.sh /opt/app/weekly-uptime.sh
RUN chmod +x /opt/app/weekly-uptime.sh
CMD ["/opt/app/weekly-uptime.sh"]

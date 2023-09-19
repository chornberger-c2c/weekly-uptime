FROM alpine:latest
RUN mkdir -p /opt/app
ADD weekly-uptime-ai-assisted-final.sh /opt/app/weekly-uptime.sh
RUN chmod +x /opt/app/weekly-uptime.sh
CMD ["/opt/app/weekly-uptime.sh"]

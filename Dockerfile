FROM alpine:latest
ADD --chmod=755 weekly-uptime-ai-assisted-final.sh /opt/app/weekly-uptime.sh
CMD ["/opt/app/weekly-uptime.sh"]

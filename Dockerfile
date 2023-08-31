FROM ubuntu:22.04
ADD --chmod=755 ai-assisted/weekly-uptime-ai-assisted-final.sh /opt/app/weekly-uptime.sh
CMD ["/opt/app/weekly-uptime.sh"]

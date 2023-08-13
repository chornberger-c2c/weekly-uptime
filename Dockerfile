FROM ubuntu:22.04
ADD --chmod=755 weekly-uptime.sh /opt/app/weekly-uptime.sh
CMD ["/opt/app/weekly-uptime.sh"]
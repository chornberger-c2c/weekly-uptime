FROM ubuntu:22.04
ADD weekly-uptime.sh /weekly-uptime.sh
RUN chmod +x /weekly-uptime.sh
CMD ["/weekly-uptime.sh"]

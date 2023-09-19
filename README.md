[![Docker Repository on Quay](https://quay.io/repository/chornberger/weekly-uptime/status "Docker Repository on Quay")](https://quay.io/repository/chornberger/weekly-uptime)
# weekly-uptime

It shows the uptime of your workstation for this week.

To run weekly-uptime on Debian based systems with Docker:
```
docker run -v /var/log/wtmp:/var/log/wtmp quay.io/chornberger/weekly-uptime
```

And on RHEL systems with podman:
```
sudo podman run -v /var/log/wtmp:/var/log/wtmp:Z quay.io/chornberger/weekly-uptime
```

There is also a version that was written with assistance of AI:

Docker:
```
docker run -v /var/log/wtmp:/var/log/wtmp quay.io/chornberger/weekly-uptime:ai-assisted
```
podman:
```
sudo podman run -v /var/log/wtmp:/var/log/wtmp:Z quay.io/chornberger/weekly-uptime:ai-assisted
```

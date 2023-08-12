# weekly-uptime

It shows the uptime of your workstation for this week.

To run weekly-uptime on Debian based systems:
```
docker run -v /var/log/wtmp:/var/log/wtmp quay.io/chornberger/weekly-uptime
```

And on RHEL systems:
```
sudo podman run -v /var/log/wtmp:/var/log/wtmp:Z quay.io/chornberger/weekly-uptime
```
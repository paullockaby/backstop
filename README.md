# backstop
A system that will return the same document regardless of what page is requested.

## Running

To run this container image, simply run this command, or some variation on it:

```
docker run --rm -d -p 8080:80/tcp \
  -e HTTPD_PROXY_PROTOCOL=On \
  -e HTTPD_SERVER_NAME=localhost:8080 \
  -e HTTPD_SERVER_ADMIN=paul@paullockaby.com \
  ghcr.io/paullockaby/backstop:v1.1.0
```

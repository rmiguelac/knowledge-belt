# Docker one-liners

Commands to run docker stuff, helpful in day-to-day activities

## Table of contents

* [Run infinite container with some log](#run-infinite-container-with-some-log)

### Run infinite container with some log

```bash
docker run -d --rm --name dummy-app busybox /bin/sh -c "while true; do date; sleep 5; done"
```
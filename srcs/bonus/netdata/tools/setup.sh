#!/bin/bash

# sed -i 's/# bind to = \*/bind to = 0.0.0.0/' /etc/netdata/netdata.conf

exec netdata -D -u root
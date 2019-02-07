#!/bin/sh
HABITUS_VER=1.0.4
HABITUS_URL=https://github.com/cloud66-oss/habitus/releases/download/${HABITUS_VER}/habitus_linux_amd64
wget -qO /usr/bin/habitus $HABITUS_URL
chmod +x /usr/bin/habitus

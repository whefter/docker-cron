#!/bin/bash

cronfile=/etc/crontab
cat /dev/null > "${cronfile}"
for cronvar in ${!CRON_*}; do
        cronvalue=${!cronvar}
        echo "Installing: $cronvalue"
        FIRSTPART=$(echo "$cronvalue" | cut -d " " -f 1-6)
        SECONDPART=$(echo "$cronvalue" | cut -d " " -f 7-)
        NAME="CRON: ${cronvalue}"
        echo "${FIRSTPART} echo ${NAME@Q} > /proc/1/fd/1 && ${SECONDPART} >/proc/1/fd/1 2>/proc/1/fd/2" >> "${cronfile}"
done

chmod 0644 "${cronfile}"

echo "[$(date -Iseconds)] Starting cron in foreground"
cron -f

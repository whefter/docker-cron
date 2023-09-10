#!/bin/bash

cronfile=/etc/crontabs/root
cat /dev/null > "${cronfile}"

for JOB_NAME in ${!CRON_*}; do
    JOB_RAW=${!JOB_NAME}
    JOB_SCHEDULE=$(echo "$JOB_RAW" | cut -d " " -f 1-5)
    JOB_COMMAND=$(echo "$JOB_RAW" | cut -d " " -f 6-)

    # No need to print the name, Alpine's crond in -d 8 gives us this information.
    # echo "${JOB_SCHEDULE} echo ${JOB_NAME} > /proc/1/fd/1 && ${JOB_COMMAND} >/proc/1/fd/1 2>/proc/1/fd/2" >> "${cronfile}"
    echo "${JOB_SCHEDULE} ${JOB_COMMAND} >/proc/1/fd/1 2>/proc/1/fd/2" >> "${cronfile}"
done

chmod 0644 "${cronfile}"

echo "--- Constructed Cronfile:"
cat "${cronfile}"

echo "[$(date -Iseconds)] Starting cron in foreground"
crond -f -d 8

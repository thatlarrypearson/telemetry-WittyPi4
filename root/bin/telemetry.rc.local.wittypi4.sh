#!/usr/bin/bash
#
# telemetry.rc.local.wittypi4 - This script is executed by the system /etc/rc.local script on system boot

export START_DELAY=60
export WITTYPI4_USER="lbp"
export WITTYPI4_GROUP="i2c"
export WITTYPI4_HOME="/home/${WITTYPI4_USER}"
export DEBUG="True"
export TMP_DIR="/root/tmp"
export LOG_FILE="${TMP_DIR}/telemetry-wittypi4_$(date '+%Y-%m-%d_%H:%M:%S').log"

if [ ! -d "${TMP_DIR}" ]
then
        mkdir --parents "${TMP_DIR}"
fi

# redirect all stdout and stderr to file
exec &> "${LOG_FILE}"

# Debugging support
if [ "${DEBUG}" = "True" ]
then
        # enable shell debug mode
        set -x
fi

# turn off stdin
0<&-

sleep "${START_DELAY}"

## Run the script boot_config.sh as user "${WITTYPI4_USER}" and group "${WITTYPI4_GROUP}"
runuser -u "${WITTYPI4_USER}" -g "${WITTYPI4_GROUP}" "${WITTYPI4_HOME}/telemetry-wittypi4/bin/boot_config.sh" &


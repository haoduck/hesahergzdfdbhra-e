#!/bin/bash
MACHINE=64
XRAY_FILE="Xray-linux-${MACHINE}.zip"
XRAY_URL="https://github.com/XTLS/Xray-core/releases/latest/download/${XRAY_FILE}"
XRAY_PATH="/usr/xray/"
mkdir -p ${XRAY_PATH}
down(){
wget -O /tmp/${XRAY_FILE} ${XRAY_URL}
unzip -o /tmp/${XRAY_FILE} "xray" "geoip.dat" "geosite.dat" -d ${XRAY_PATH} && rm -f /tmp/${XRAY_FILE}
cat <<EOF > ${XRAY_PATH}config.json
{
    "inbounds": [{
        "port": 8080,
        "protocol": "vmess",
        "settings": {
            "clients": [{
                "id": "8c35bef3-d51f-41ab-ac87-7b053410495b",
                "alterId": 64
            }]
        },
        "streamSettings": {
            "network": "ws",
            "wsSettings": {
                "path": "/"
            }
        }
    }],
    "outbounds": [{
        "protocol": "freedom"
    }]
}
EOF
}
if [[ ! -f ${XRAY_FILE} ]] || [[ ! -f ${XRAY_PATH}config.json ]];then
    down
fi
${XRAY_FILE} -c ${XRAY_PATH}config.json
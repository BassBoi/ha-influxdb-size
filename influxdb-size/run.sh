#!/bin/bash

INTERVAL=$(bashio::config 'interval')
PREFIX=$(bashio::config 'mqtt_prefix')

# MQTT credentials from Supervisor
MQTT_HOST=$(bashio::services "mqtt" "host")
MQTT_PORT=$(bashio::services "mqtt" "port")
MQTT_USER=$(bashio::services "mqtt" "username")
MQTT_PASS=$(bashio::services "mqtt" "password")

DISCOVERY_TOPIC="$PREFIX/sensor/influxdb_size/config"
STATE_TOPIC="$PREFIX/sensor/influxdb_size/state"

# Auto-discovery payload
CONFIG_PAYLOAD=$(cat <<EOF
{
  "name": "InfluxDB Size",
  "state_topic": "$STATE_TOPIC",
  "unit_of_measurement": "M",
  "unique_id": "influxdb_size_sensor",
  "icon": "mdi:database"
}
EOF
)

publish() {
  mosquitto_pub -h "$MQTT_HOST" -p "$MQTT_PORT" \
    -u "$MQTT_USER" -P "$MQTT_PASS" \
    -t "$1" -m "$2" -r
}

# Publish auto-discovery config
publish "$DISCOVERY_TOPIC" "$CONFIG_PAYLOAD"

# Main loop
while true; do
    SIZE=$(du -s /mnt/data/supervisor/addons/data/*influxdb* 2>/dev/null | awk '{print $1}')
    SIZE=${SIZE:-0}

    publish "$STATE_TOPIC" "$SIZE"

    sleep "$INTERVAL"
done

# HA InfluxDB Size Monitor Add-on

TESTING PHASE

This Home Assistant add-on reports the size of the InfluxDB add-on data directory using MQTT with auto-discovery.

## Features

- Reads size from: `/mnt/data/supervisor/addons/data/*influxdb*`
- Publishes via MQTT
- Auto-discovers as a Home Assistant sensor
- Configurable interval

## Installation

1. Add this repository to Home Assistant:
   **Settings → Add-ons → Add-on Store → Repositories**
2. Install **InfluxDB Size Monitor**
3. Start the add-on
4. A sensor named **InfluxDB Size** will appear automatically

## Configuration

```yaml
interval: 1800
mqtt_prefix: "homeassistant"

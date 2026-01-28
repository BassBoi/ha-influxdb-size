# InfluxDB Size Sensor (HACS)

This integration adds a sensor that reports the size of the InfluxDB add-on data directory.

## Installation

1. Go to HACS → Integrations → Custom Repositories
2. Add:
   `https://github.com/YOUR_GITHUB/ha-influxdb-size`
3. Install "InfluxDB Size Sensor"
4. Add to configuration.yaml:

```yaml
sensor:
  - platform: influxdb_size
    interval: 1800

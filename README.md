# InfluxDB Size Sensor (HACS)

This integration adds a sensor that reports the size of the InfluxDB add-on data directory.

## Installation

1. Go to HACS → Integrations → Custom Repositories
2. Add:
   `https://github.com/BassBoi/ha-influxdb-size`
3. Choose category: **Integration**
4. Install **InfluxDB Size Sensor**
5. Add to `configuration.yaml`:

```yaml
sensor:
  - platform: influxdb_size
    interval: 1800



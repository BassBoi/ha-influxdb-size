import os
import glob
import subprocess
from datetime import timedelta

from homeassistant.components.sensor import SensorEntity
from homeassistant.const import DATA_MEGABYTES
from homeassistant.helpers.event import async_track_time_interval

from .const import DOMAIN, DEFAULT_INTERVAL, ADDON_PATTERN

async def async_setup_platform(hass, config, add_entities, discovery_info=None):
    interval = config.get("interval", DEFAULT_INTERVAL)
    sensor = InfluxDBSizeSensor(hass)
    add_entities([sensor])

    async def update(now):
        await sensor.async_update_ha_state(True)

    async_track_time_interval(hass, update, timedelta(seconds=interval))


class InfluxDBSizeSensor(SensorEntity):
    _attr_name = "InfluxDB Size"
    _attr_native_unit_of_measurement = "M"

    async def async_update(self):
        # Supervisor add-on data path
        base = "/mnt/data/supervisor/addons/data/"
        matches = glob.glob(os.path.join(base, ADDON_PATTERN))

        if not matches:
            self._attr_native_value = 0
            return

        try:
            result = subprocess.check_output(["du", "-s", matches[0]])
            size = int(result.split()[0])
            self._attr_native_value = size
        except Exception:
            self._attr_native_value = 0

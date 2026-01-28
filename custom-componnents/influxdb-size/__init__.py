from homeassistant.core import HomeAssistant
from homeassistant.helpers.discovery import load_platform

async def async_setup(hass: HomeAssistant, config: dict):
    hass.data.setdefault("influxdb_size", {})
    return True

# Motion Master for NVIDIA Jetson AGX Thor

Runs Motion Master (arm64), its HTTP API and the OBLAC Drives UI in Docker.

## Start

1. Find the MAC address of the network interface the drive is connected to:
   `ip -br link`
2. Start the containers:
   ```bash
   MM_MAC=<mac address> docker compose up -d --build
   ```
3. Open the UI at `http://<thor-ip>:63527`.

Stop with `docker compose down`. Make sure no other Motion Master (for example a
system service) is running on the same network interface.

## Settings

Set as environment variables or in a `.env` file next to `docker-compose.yml`:
`MM_MAC` (required), `MM_PDO_MODE` (`monitor` by default, `control` to command
drives), `MM_REQ_RES_PORT`, `MM_PUB_SUB_PORT`, `MM_API_PORT`, `OBLAC_DRIVES_PORT`.

## Limitations

- Auto-tuning is supported.
- Narrow-angle encoder calibration is not available in this build.

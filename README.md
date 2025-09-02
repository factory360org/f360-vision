<div align="center">
		<img src="docs/logo.png" alt="Factory360 Logo" />
</div>

# f360 Vision

## Hosting

### Requirements

Install Docker and login to the GitHub docker registry using the token that was provided:

```sh
docker login ghcr.io -u f360-vision-user -p <your_token>
```

### Setup

#### Linux / MacOS

```sh
curl -fsSL https://raw.githubusercontent.com/factory360org/f360-vision/main/unix/install.sh | bash
```

#### Windows

```powershell
irm https://raw.githubusercontent.com/factory360org/f360-vision/main/install.ps1 | iex
```

#### Start

Run the start script with administrator / sudo rights. This will pull the Docker images and start the containers.

#### Stop

Run the stop script.

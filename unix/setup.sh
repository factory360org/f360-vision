cp .env.example .env

sed -i "s/^VIEWER_BACKEND_API_KEY=.*/VIEWER_BACKEND_API_KEY=$(openssl rand -hex 32)/" .env

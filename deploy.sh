#!/bin/bash
# Deployment script for opencbbl

echo "=== Deploying opencbbl to production ==="

# 1. Install PostgreSQL on host (if not installed)
echo "1. Setting up PostgreSQL..."
sudo apt update
sudo apt install -y postgresql postgresql-contrib

# 2. Create database and user
sudo -u postgres psql -c "CREATE USER opencbbl WITH PASSWORD 'YOUR_STRONG_PASSWORD';"
sudo -u postgres psql -c "CREATE DATABASE opencbbl OWNER opencbbl;"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE opencbbl TO opencbbl;"

# 3. Create .env file
echo "2. Creating .env file..."
cat > .env << EOF
SECRET_KEY=your-secret-key-here
DEBUG=False
ALLOWED_HOSTS=mikesdemos.ru,www.mikesdemos.ru,localhost,127.0.0.1

DB_ENGINE=django.db.backends.postgresql
DB_NAME=opencbbl
DB_USER=opencbbl
DB_PASSWORD=YOUR_STRONG_PASSWORD
DB_HOST=localhost
DB_PORT=5432

YANDEX_GEOCODER_API_KEY=b32b31d1-1157-4757-a682-66b6dbd87544
FNS_API_KEY=7fa73c57b7386e64f4c0d2fe55787d101b579694
EOF

# 4. Build and start containers
echo "3. Building Docker containers..."
docker-compose build

echo "4. Starting services..."
docker-compose up -d

# 5. Run migrations
echo "5. Running migrations..."
docker-compose exec -T web python manage.py migrate

# 6. Collect static files
echo "6. Collecting static files..."
docker-compose exec -T web python manage.py collectstatic --noinput

echo "=== Deployment complete ==="
echo "Application should be available at http://mikesdemos.ru/black-list-cbrf"

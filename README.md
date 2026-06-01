# OpenCBBL - Карта компаний из списка ЦБ РФ

Проект на Django для визуализации компаний с выявленными признаками нелегальной деятельности на финансовом рынке из официального списка Центрального Банка РФ.

## Возможности

- 🗺️ Интерактивная карта с точками организаций
- 🔍 Фильтры по субъектам РФ и признакам нелегальной деятельности
- 📊 Статистика по организациям
- 🔄 Автоматическая синхронизация с API ЦБ РФ
- 🌐 REST API для интеграции

## Технологический стек

- **Backend**: Django 4.2 + Django REST Framework
- **Frontend**: HTML + JavaScript + Leaflet.js
- **Database**: SQLite (по умолчанию) / PostgreSQL (для production)
- **API**: ЦБ РФ Warning List API

## Установка и запуск

### 1. Клонирование и установка зависимостей

```bash
cd C:\develop\opencbbl
python -m venv venv
venv\Scripts\activate
pip install -r requirements.txt
```

### 2. Настройка окружения

```bash
copy .env.example .env
```

Отредактируйте `.env` при необходимости.

### 3. Создание базы данных и миграции

```bash
python manage.py migrate
```

### 4. Синхронизация данных с ЦБ РФ

```bash
python manage.py sync_cbr
```

Эта команда загрузит справочники регионов и признаков нелегальной деятельности, а также все организации из списка ЦБ РФ.

### 5. Создание суперпользователя (опционально)

```bash
python manage.py createsuperuser
```

### 6. Запуск сервера

```bash
python manage.py runserver
```

Приложение будет доступно по адресу: http://localhost:8000

## API endpoints

- `GET /api/regions/` - список субъектов РФ
- `GET /api/themas/` - список признаков нелегальной деятельности
- `GET /api/organizations/` - список организаций (с фильтрами)
- `GET /api/organizations/map_points/` - точки для карты
- `GET /api/organizations/stats/` - статистика

### Фильтрация организаций

```
GET /api/organizations/?region=1&thema=2
GET /api/organizations/?search=название
```

## Структура проекта

```
opencbbl/
├── opencbbl/              # Основные настройки Django
├── organizations/         # Приложение для моделей организаций
│   ├── models.py          # Модели: Region, Thema, Organization
│   ├── services.py        # CBR API сервис
│   └── management/       # Management команды
├── api/                   # Django REST Framework API
│   ├── serializers.py     # Сериализаторы
│   ├── views.py          # API ViewSets
│   └── urls.py           # API URLs
├── templates/             # HTML шаблоны
├── static/               # Статические файлы
├── manage.py            # Django manage script
├── requirements.txt     # Зависимости Python
└── README.md           # Этот файл
```

## Административная панель

Админ-панель Django доступна по адресу: http://localhost:8000/admin/

Позволяет управлять:
- Субъектами РФ
- Признаками нелегальной деятельности
- Организациями

## Обновление данных

Для обновления данных из ЦБ РФ выполните:

```bash
python manage.py sync_cbr
```

Можно добавить это в cron для автоматического обновления.

## Источники данных

- [ЦБ РФ Warning List API](https://cbr.ru/warninglistapi/swagger)
- [Список компаний с признаками нелегальной деятельности](https://cbr.ru/inside/warning-list/)

## Лицензия

MIT License

## Отказ от ответственности

Проект использует официальные открытые данные Центрального Банка РФ. Вся информация взята из публичного реестра и предоставляется "как есть" в информационных целях.

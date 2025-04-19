#!/bin/bash

# اسکریپت تعویض دیتابیس x-ui با نسخه جدید از GitHub

# لینک مستقیم به فایل دیتابیس روی GitHub — حتماً فایل x-ui.db در این مسیر باشه
DB_URL="https://raw.githubusercontent.com/ProjectV2V/DBchange/main/x-ui.db"

# توقف سرویس x-ui
echo "⏹ توقف x-ui..."
systemctl stop x-ui

# دانلود دیتابیس جدید
echo "⬇ در حال دانلود دیتابیس جدید از GitHub..."
wget -O /etc/x-ui/x-ui.db "$DB_URL"

# تنظیم دسترسی
echo "🔐 تنظیم دسترسی فایل دیتابیس..."
chown root:root /etc/x-ui/x-ui.db
chmod 600 /etc/x-ui/x-ui.db

# راه‌اندازی مجدد سرویس
echo "✅ راه‌اندازی مجدد x-ui..."
systemctl restart x-ui

# لاگ وضعیت
echo "✅ x-ui database updated successfully on $(date)" > /root/db_update.log

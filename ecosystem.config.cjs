module.exports = {
  apps: [
    {
      name: 'b2bbaby-ssr',
      script: './dist/server/entry.mjs',
      cwd: '/www/wwwroot/b2bbaby/frontend',
      instances: 1,
      exec_mode: 'fork',
      env: {
        NODE_ENV: 'production',
        PORT: '4321',
        HOST: '0.0.0.0',
        SMTP_HOST: 'smtp.gmail.com',
        SMTP_PORT: '587',
        SMTP_USER: 'info@b2bbaby.com',
        SMTP_PASS: '',
        SMTP_TO: 'sales@b2bbaby.com',
      },
      max_memory_restart: '256M',
      log_date_format: 'YYYY-MM-DD HH:mm:ss',
      error_file: '/www/wwwlogs/b2bbaby-frontend-error.log',
      out_file: '/www/wwwlogs/b2bbaby-frontend-out.log',
      merge_logs: true,
      restart_delay: 1000,
      autorestart: true,
      watch: false,
      kill_timeout: 5000,
      wait_ready: true,
      listen_timeout: 10000,
    }
  ]
};
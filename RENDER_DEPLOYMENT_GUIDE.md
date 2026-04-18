# ========================================
# GUÍA PARA CONFIGURAR RENDER
# ========================================

## PASO 1: En Render, ve a Settings > Environment

Copia y pega estas variables de entorno:

### Variables Obligatorias para Render:

ASPNETCORE_ENVIRONMENT=Production

### Variables de Conexión a Base de Datos:
## (Usa una sola BD en Render, recomendamos PostgreSQL)

# PostgreSQL (RECOMENDADO PARA RENDER)
ConnectionStrings__PostgresDb=Host=tu-host-postgres.railway.app;Port=5432;Database=modelsecurity;Username=postgres;Password=TU_PASSWORD_AQUI;SSL Mode=Require

# O SQL Server (si la tienes)
ConnectionStrings__SqlServerConnection=Server=tu-servidor.database.windows.net,1433;Database=modelsecurity;User Id=tu_usuario;Password=TU_PASSWORD_AQUI;Encrypt=true;TrustServerCertificate=false;Connection Timeout=30;

# O MySQL (si la tienes)
ConnectionStrings__MySqlConnection=Server=tu-host-mysql.railway.app;Port=3306;Database=modelsecurity;User=root;Password=TU_PASSWORD_AQUI

### Configuración JWT:

Jwt__Key=EsteEsUnSecretoSuperSeguroDeMasDe32Caracteres!!MasOtrosCaracteres

Jwt__Issuer=MiApi

Jwt__Audience=MiApiUsuarios


## PASO 2: Comandos de Deploy

Build Command:
dotnet publish -c Release -o out --project Web/Web.csproj

Start Command:
dotnet out/Web.dll


## PASO 3: Verificar Deployment

Una vez deployado, Render mostrará la URL.
La API estará disponible en: https://tu-app.onrender.com

Endpoints disponibles:
- GET  /swagger/ui  (Documentación Swagger)
- POST /api/auth/login
- POST /api/auth/register
- GET  /api/auth/database-status


## ⚠️ IMPORTANTE:

1. NO copies el contenido de appsettings.json a Render
   Las ConnectionStrings vienen SOLO de variables de entorno

2. La Jwt:Key DEBE ser la misma en desarrollo y producción
   Cópiala de tu appsettings.json

3. Si tienes múltiples BDs, Render intentará conectar a todas
   Es normal que algunas fallen si no están configuradas


## 🔒 Seguridad:

✅ Nunca commits secretos a GitHub
✅ Usa variables de entorno en Render
✅ La Jwt:Key está protegida en Render
✅ Las conexiones a BD usan SSL en producción

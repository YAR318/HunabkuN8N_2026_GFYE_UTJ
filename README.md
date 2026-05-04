# HunabkuN8N 2026 GFYE UTJ 

Este repositorio contiene la arquitectura completa en microservicios del proyecto **HunabkuN8N**, que integra paneles de administración (Filament), un sistema de autenticación centralizado (SSO) y la infraestructura de automatización con n8n y WhatsApp (Evolution API).

##  Arquitectura del Proyecto

El ecosistema está construido en base a submódulos de Git para mantener el código organizado e independiente. Los componentes principales son:

- **[hk-filament-est](https://github.com/YAR318/hk-filament-est)**: Panel administrativo principal de la aplicación construido con Laravel y Filament.
- **[HK_Autenticacion_EST](https://github.com/YAR318/HK_Autenticacion_EST)**: Sistema de inicio de sesión único (SSO) y recuperación de contraseñas.
- **Evolution API / n8n / MySQL / Redis**: Entorno Docker centralizado que orquesta la infraestructura, base de datos y la automatización inteligente.

---

##  Requisitos Previos

Antes de instalar, asegúrate de tener instalado en tu sistema:
- [Git](https://git-scm.com/)
- [Docker](https://www.docker.com/) y [Docker Compose](https://docs.docker.com/compose/)

---

##  Instrucciones de Instalación

### 1. Clonar el repositorio
Es **crítico** utilizar la bandera `--recursive` al clonar para que Git descargue automáticamente los submódulos de Filament y Autenticación.

```bash
git clone --recursive https://github.com/YAR318/HunabkuN8N_2026_GFYE_UTJ.git
cd HunabkuN8N_2026_GFYE_UTJ
```
*(Si ya clonaste sin la bandera `--recursive`, ejecuta: `git submodule update --init --recursive`)*

### 2. Configurar Variables de Entorno (.env)
Deberás configurar los archivos `.env` basándote en los ejemplos (`.env.example`) correspondientes de cada proyecto.

1. **Evolution API**: 
   Crea el archivo `.env` en la carpeta `evolution-api/` con las claves de acceso para tu API de WhatsApp.
2. **Panel Filament**: 
   Ingresa a `hk-filament-est/` y duplica `.env.example` a `.env`. Asegúrate de configurar la base de datos para que apunte al servicio MySQL de Docker (`DB_HOST=mysql`).
3. **Autenticación**: 
   Haz lo mismo en `HK_Autenticacion_EST/`. Configura el `.env` con tus llaves de Resend para el OTP.

### 3. Levantar la Infraestructura Docker
El archivo de orquestación de Docker se encuentra dentro de la carpeta `evolution-api`.

```bash
cd evolution-api
docker-compose up -d
```
Este comando levantará:
- Servidor web de Filament (Puerto 8000)
- Servidor web de Autenticación (Puerto 8001)
- Base de datos MySQL compartida (Puerto 3306)
- Servidor Redis para caché (Puerto 6379)
- Evolution API v2 (Puerto 8080)
- Motor de automatización n8n (Puerto 5678)

### 4. Instalar Dependencias y Base de Datos (Laravel)
Finalmente, ejecuta las migraciones para inicializar la base de datos MySQL (solo la primera vez).

**Para el panel de Filament:**
```bash
docker exec -it hk-filament bash -c "composer install && php artisan key:generate && php artisan migrate:fresh --seed"
```

**Para la API de Autenticación:**
```bash
docker exec -it hk-autenticacion bash -c "composer install && php artisan key:generate && php artisan migrate:fresh --seed"
```

---

##  Accesos del Sistema

Una vez levantados todos los servicios, puedes acceder a través de tu navegador local:

- **Panel Administrativo (Filament)**: `http://localhost:8000`
- **N8N (Automatización)**: `http://localhost:5678`
- **Evolution API**: `http://localhost:8080`

Para vincular WhatsApp, entra al panel de Filament, dirígete a **Ajustes > Configuración** y escanea el código QR en la sección de **Evolution API**.

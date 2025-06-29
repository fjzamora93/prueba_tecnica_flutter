# Dockerfile
FROM python:3.11-alpine

# Crear directorio de trabajo
WORKDIR /app

# Copiar solo los archivos del build web
COPY build/web/ /app/

# Exponer puerto
EXPOSE 8080

# Ejecutar servidor HTTP simple
CMD ["python", "-m", "http.server", "8080"]
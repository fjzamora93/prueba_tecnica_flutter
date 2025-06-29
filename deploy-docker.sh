#!/bin/bash
# deploy-docker.sh

set -e

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuración
DOCKER_HUB_USER="fjzamora93"
IMAGE_NAME="kidsandclouds"
FULL_IMAGE_NAME="${DOCKER_HUB_USER}/${IMAGE_NAME}"
CONTAINER_NAME="kidsandclouds-container"
PORT="8080"
VERSION=$(date +%Y%m%d-%H%M%S)

echo -e "${BLUE}🐳 Deploying Flutter Web to Docker Hub${NC}"
echo "========================================"

# Función para mostrar ayuda
show_help() {
    echo "Uso: $0 [OPCIONES]"
    echo ""
    echo "Opciones:"
    echo "  -p, --port PORT     Puerto para exponer (default: 8080)"
    echo "  -t, --tag TAG       Tag para la imagen (default: timestamp)"
    echo "  --push-only         Solo hacer push (sin ejecutar localmente)"
    echo "  --local-only        Solo ejecutar localmente (sin push)"
    echo "  -h, --help          Mostrar esta ayuda"
    echo ""
    echo "Ejemplos:"
    echo "  $0                  # Build, push y ejecutar"
    echo "  $0 -p 3000          # Deploy en puerto 3000"
    echo "  $0 -t v1.0.0        # Deploy con tag específico"
    echo "  $0 --push-only      # Solo subir a Docker Hub"
    echo "  $0 --local-only     # Solo ejecutar localmente"
}

# Variables de control
PUSH_TO_HUB=true
RUN_LOCAL=true

# Procesar argumentos
while [[ $# -gt 0 ]]; do
    case $1 in
        -p|--port)
            PORT="$2"
            shift 2
            ;;
        -t|--tag)
            VERSION="$2"
            shift 2
            ;;
        --push-only)
            PUSH_TO_HUB=true
            RUN_LOCAL=false
            shift
            ;;
        --local-only)
            PUSH_TO_HUB=false
            RUN_LOCAL=true
            shift
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            echo -e "${RED}❌ Opción desconocida: $1${NC}"
            show_help
            exit 1
            ;;
    esac
done

# Verificar que Flutter está instalado
if ! command -v flutter &> /dev/null; then
    echo -e "${RED}❌ Flutter no está instalado${NC}"
    exit 1
fi

# Verificar que Docker está corriendo
if ! docker info &> /dev/null; then
    echo -e "${RED}❌ Docker no está corriendo${NC}"
    exit 1
fi

echo -e "${YELLOW}📋 Configuración:${NC}"
echo "  - Imagen Docker Hub: ${FULL_IMAGE_NAME}:${VERSION}"
echo "  - Contenedor local: ${CONTAINER_NAME}"
echo "  - Puerto: ${PORT}"
echo "  - Push a Docker Hub: $([ "$PUSH_TO_HUB" = true ] && echo "✅ Sí" || echo "❌ No")"
echo "  - Ejecutar local: $([ "$RUN_LOCAL" = true ] && echo "✅ Sí" || echo "❌ No")"
echo ""

# Paso 1: Generar build web
echo -e "${YELLOW}🔨 Generando build web de Flutter...${NC}"

# Instalar dependencias si es necesario
flutter pub get

# Generar archivos de código
dart run build_runner build --delete-conflicting-outputs

# Generar build web
flutter build web --release

if [ ! -d "build/web" ]; then
    echo -e "${RED}❌ Error: No se generó el directorio build/web${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Build web generado exitosamente${NC}"

# Paso 2: Construir imagen Docker
echo -e "${YELLOW}🐳 Construyendo imagen Docker...${NC}"
docker build -t ${FULL_IMAGE_NAME}:${VERSION} -t ${FULL_IMAGE_NAME}:latest .

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Imagen construida exitosamente${NC}"
else
    echo -e "${RED}❌ Error construyendo la imagen${NC}"
    exit 1
fi

# Paso 3: Push a Docker Hub (si está habilitado)
if [ "$PUSH_TO_HUB" = true ]; then
    echo -e "${YELLOW}🔐 Verificando login en Docker Hub...${NC}"
    
    # Verificar si está logueado
    if ! docker info | grep -q "Username:"; then
        echo -e "${YELLOW}🔑 Necesitas hacer login en Docker Hub...${NC}"
        echo "Ejecuta: docker login"
        echo "Usuario: ${DOCKER_HUB_USER}"
        read -p "¿Quieres hacer login ahora? (y/n): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            docker login
        else
            echo -e "${RED}❌ Login cancelado. No se puede hacer push.${NC}"
            PUSH_TO_HUB=false
        fi
    fi
    
    if [ "$PUSH_TO_HUB" = true ]; then
        echo -e "${YELLOW}📤 Subiendo imagen a Docker Hub...${NC}"
        
        # Push con tag específico
        docker push ${FULL_IMAGE_NAME}:${VERSION}
        
        # Push como latest
        docker push ${FULL_IMAGE_NAME}:latest
        
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}✅ Imagen subida exitosamente a Docker Hub${NC}"
            echo -e "${BLUE}🌐 Imagen disponible en: https://hub.docker.com/r/${DOCKER_HUB_USER}/${IMAGE_NAME}${NC}"
        else
            echo -e "${RED}❌ Error subiendo la imagen${NC}"
        fi
    fi
fi

# Paso 4: Ejecutar contenedor localmente (si está habilitado)
if [ "$RUN_LOCAL" = true ]; then
    echo -e "${YELLOW}🧹 Limpiando contenedor anterior...${NC}"
    docker stop ${CONTAINER_NAME} 2>/dev/null || true
    docker rm ${CONTAINER_NAME} 2>/dev/null || true

    echo -e "${YELLOW}🚀 Ejecutando contenedor...${NC}"
    docker run -d \
        --name ${CONTAINER_NAME} \
        -p ${PORT}:8080 \
        --restart unless-stopped \
        ${FULL_IMAGE_NAME}:latest

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Contenedor ejecutándose exitosamente${NC}"
    else
        echo -e "${RED}❌ Error ejecutando el contenedor${NC}"
        exit 1
    fi

    # Verificar que está corriendo
    echo -e "${YELLOW}🔍 Verificando estado...${NC}"
    sleep 2

    if docker ps | grep -q ${CONTAINER_NAME}; then
        echo -e "${GREEN}✅ Aplicación desplegada exitosamente${NC}"
        echo ""
        echo -e "${BLUE}🌐 Aplicación disponible en:${NC}"
        echo "   http://localhost:${PORT}"
        echo ""
        echo -e "${BLUE}📊 Comandos útiles:${NC}"
        echo "   Ver logs:        docker logs ${CONTAINER_NAME}"
        echo "   Ver logs live:   docker logs -f ${CONTAINER_NAME}"
        echo "   Parar:          docker stop ${CONTAINER_NAME}"
        echo "   Reiniciar:      docker restart ${CONTAINER_NAME}"
        echo "   Eliminar:       docker rm -f ${CONTAINER_NAME}"
        echo ""
        echo -e "${BLUE}🐳 Información del contenedor:${NC}"
        docker ps --filter "name=${CONTAINER_NAME}" --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
    else
        echo -e "${RED}❌ El contenedor no está corriendo${NC}"
        echo "Logs del contenedor:"
        docker logs ${CONTAINER_NAME}
        exit 1
    fi
fi

echo ""
echo -e "${GREEN}🎉 ¡Deploy completado!${NC}"

if [ "$PUSH_TO_HUB" = true ]; then
    echo -e "${BLUE}📦 Imagen en Docker Hub: ${FULL_IMAGE_NAME}:${VERSION}${NC}"
    echo -e "${BLUE}📦 También disponible como: ${FULL_IMAGE_NAME}:latest${NC}"
    echo ""
    echo -e "${YELLOW}🔄 Para usar en otros lugares:${NC}"
    echo "   docker pull ${FULL_IMAGE_NAME}:latest"
    echo "   docker run -p 8080:8080 ${FULL_IMAGE_NAME}:latest"
fi

if [ "$RUN_LOCAL" = true ]; then
    echo -e "${BLUE}🏠 Aplicación corriendo localmente en: http://localhost:${PORT}${NC}"
fi
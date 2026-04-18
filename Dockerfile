# Etapa 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /src

# Copiar archivos de proyecto
COPY ["Web/Web.csproj", "Web/"]
COPY ["Business/Business.csproj", "Business/"]
COPY ["Data/Data.csproj", "Data/"]
COPY ["Entity/Entity.csproj", "Entity/"]
COPY ["Utilities/Utilities.csproj", "Utilities/"]

# Restaurar dependencias
RUN dotnet restore "Web/Web.csproj"

# Copiar todo el código
COPY . .

# Compilar y publicar
RUN dotnet publish "Web/Web.csproj" -c Release -o /app/publish

# Etapa 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0

WORKDIR /app

# Copiar archivos publicados desde la etapa build
COPY --from=build /app/publish .

# Configurar puerto dinámico para Render
ENV ASPNETCORE_URLS=http://+:${PORT:-5000}
ENV ASPNETCORE_ENVIRONMENT=Production

# Exponer puerto
EXPOSE 5000

# Comando de inicio
ENTRYPOINT ["dotnet", "Web.dll"]
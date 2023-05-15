FROM node:18 AS front
WORKDIR /front

COPY ./LegalProvisionsApplication/ .

RUN npm install && npm run build



FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

RUN apt-get update && apt-get -y install nano


FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build

WORKDIR /src
COPY ["LegalProvisionsBackend/LegalProvisionsBackend/LegalProvisionsBackend.csproj", "LegalProvisionsBackend/"]
COPY ["LegalProvisionsBackend/LegalProvisionsLib/LegalProvisionsLib.csproj", "LegalProvisionsLib/"]

RUN ls -la LegalProvisionsBackend

RUN dotnet restore "LegalProvisionsBackend/LegalProvisionsBackend.csproj"
COPY ./LegalProvisionsBackend .

COPY --from=front /front/dist/ LegalProvisionsBackend/wwwroot

WORKDIR "/src/LegalProvisionsBackend"
RUN dotnet build "LegalProvisionsBackend.csproj" -c Release -o /app/build


FROM build AS publish
RUN dotnet publish "LegalProvisionsBackend.csproj" -c Release -o /app/publish


FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "LegalProvisionsBackend.dll"]

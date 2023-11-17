FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY AvangardumPersonalWebsite.sln .
COPY AvangardumPersonalWebsite/AvangardumPersonalWebsite.csproj AvangardumPersonalWebsite/
RUN dotnet restore
COPY . .
RUN dotnet publish -c Release -p:UseAppHost=false --warnaserror --no-restore
RUN dotnet test

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
EXPOSE 80
EXPOSE 443
COPY --from=build /src/AvangardumPersonalWebsite/bin/Release/net8.0/publish .
ENTRYPOINT ["dotnet", "AvangardumPersonalWebsite.dll"]
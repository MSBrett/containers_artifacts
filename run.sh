#!/bin/bash

sudo docker run --network docker0 -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=P@ssw0rd" -p 1433:1433 --name sql1 -h sql1 -d mcr.microsoft.com/mssql/server:2017-latest

sudo docker exec -it sql1 "bash"

/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "P@ssw0rd"

create database mydrivingDB
go
select * from sys.databases
go

docker run --network docker0 -e SQLFQDN=sql1 -e SQLUSER=sa -e "SQLPASS=P@ssw0rd" -e SQLDB=mydrivingDB registrybpx4479.azurecr.io/dataload:1.0


docker build --no-cache --build-arg IMAGE_VERSION="1.0" --build-arg IMAGE_CREATE_DATE="`date -u +"%Y-%m-%dT%H:%M:%SZ"`" --build-arg IMAGE_SOURCE_REVISION="`git rev-parse HEAD`" -f Dockerfile -t "tripinsights/poi:1.0" 

# Example 1 - Set config values via environment variables
docker run --network docker0 -d -p 8080:80 --name poi -e "SQL_PASSWORD=P@ssw0rd" -e "SQL_SERVER=sql1" -e "ASPNETCORE_ENVIRONMENT=Local" tripinsights/poi:1.0
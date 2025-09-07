build:
	mvn clean install

docker-build: build
	docker build . -t malware656/spring-app-pg:latest

run:
	docker run --network spring-net -p 8080:8080 docker.io/malware656/spring-app-pg:latest

setup:
	docker network create spring-net
	docker run -d --name postgres -e POSTGRES_USER=myuser -e POSTGRES_PASSWORD=mypassword -e POSTGRES_DB=mydb -e TZ=Asia/Kolkatta -p 5432:5432 postgres:16
	docker run --network spring-net -p 8080:8080 docker.io/malware656/spring-app-pg:latest

helm:
	helm install spring-stack helm/
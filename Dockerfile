FROM openjdk:8-jre-slim-buster

WORKDIR /minecraft

RUN apt-get update \
	&& apt-get install -y --no-install-recommends curl unzip jq\
	&& curl -s 'https://api.technicpack.net/modpack/tekkit-smp?build=build' | jq -r ".serverPackUrl" | xargs -I{} curl {} -o tekkit_server.zip \
	&& unzip tekkit_server.zip \
	&& rm tekkit_server.zip \
	&& chmod +x LaunchServer.sh

EXPOSE 25565/udp
EXPOSE 25565/tcp

CMD ["./LaunchServer.sh"]
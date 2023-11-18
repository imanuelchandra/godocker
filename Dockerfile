FROM debian:bullseye

MAINTAINER Chandra Lefta <lefta.chandra@gmail.com>

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update
RUN apt-get install -y iproute2 wget sudo \
                       software-properties-common \
                       apt-transport-https

RUN apt clean 

ARG A_GOLANG_VERSION=1.21.3
ENV GOLANG_VERSION=$A_GOLANG_VERSION

RUN wget https://golang.org/dl/go${A_GOLANG_VERSION}.linux-amd64.tar.gz
RUN tar -zxvf go${A_GOLANG_VERSION}.linux-amd64.tar.gz -C /usr/local/
RUN rm go${A_GOLANG_VERSION}.linux-amd64.tar.gz

ENV PATH /usr/local/go/bin:${PATH}
RUN echo "export PATH=/usr/local/go/bin:${PATH}" >> ~/.bashrc
RUN . ~/.bashrc

ENV GOTOOLCHAIN=local
ENV GOPATH /app
RUN echo "export GOPATH=/app" >> ~/.bashrc
RUN . ~/.bashrc

ADD go.sh /go.sh
RUN chmod +x /go.sh

EXPOSE 8080

ENTRYPOINT ["/go.sh"]
CMD ["eth0"]
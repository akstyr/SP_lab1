FROM debian:latest
COPY ./Ba.sh ./home
RUN chmod a+x ./home/Ba.sh
WORKDIR ./home/
MAINTAINER Ekaterina Grohotova <katya.grohotova.4@gmail.com>
CMD ["./Ba.sh"]
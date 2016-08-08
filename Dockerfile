FROM python:2.7-onbuild

ARG timezone=Etc/UTC

RUN echo $timezone > /etc/timezone \
    && ln -sfn /usr/share/zoneinfo/$timezone /etc/localtime \
    && dpkg-reconfigure -f noninteractive tzdata

RUN apt-get update && apt-get install -y openssh-server

# COPY ./configs/config-account1.json /usr/src/app/configs/config.json
# COPY ./configs/userdata-account1.js /usr/src/app/web/config/userdata.js


RUN wget -O /usr/src/app/pgoencrypt.tar.gz http://pgoapi.com/pgoencrypt.tar.gz \
        && tar -xf /usr/src/app/pgoencrypt.tar.gz -C /usr/src/app/ \
        && make -C /usr/src/app/pgoencrypt/src \
        && mv /usr/src/app/pgoencrypt/src/libencrypt.so /usr/src/app/encrypt.so

COPY web /usr/src/app/web

EXPOSE 8000

ENV LD_LIBRARY_PATH /usr/src/app
ENV PYTHONIOENCODING utf-8

WORKDIR ["/usr/src/app"]

ENTRYPOINT ["python", "pokecli.py", "--config", "configs/config.json"]

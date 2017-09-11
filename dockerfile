FROM resin/%%RESIN_MACHINE_NAME%%-python

#switch on systemd init system in container
ENV INITSYSTEM on

ENV DEVICE %%RESIN_MACHINE_NAME%%

RUN apt-get -q update && apt-get install -yq --no-install-recommends \
	cowsay \
    rfkill \
    bluez \
	&& apt-get clean && rm -rf /var/lib/apt/lists/*

RUN /usr/games/cowsay "Install dependencies in this script. This happens on the build servers!"

# pip install python deps from requirements.txt
# For caching until requirements.txt changes
COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

COPY . /usr/src/app
WORKDIR /usr/src/app

CMD ["python", "hello.py"]
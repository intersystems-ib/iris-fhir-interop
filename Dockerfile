ARG IMAGE=intersystemsdc/irishealth-community:2022.2.0.368.0-zpm
FROM $IMAGE

USER root

# copy source
RUN mkdir -p /opt/irisapp
WORKDIR /opt/irisapp
COPY iris.script iris.script
COPY src src
COPY install install

# change ownership
RUN chown -R ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /opt/irisapp

USER ${ISC_PACKAGE_MGRUSER}

# run iris.script
RUN iris start IRIS \
    && iris session IRIS < /opt/irisapp/iris.script \
    && iris stop IRIS quietly
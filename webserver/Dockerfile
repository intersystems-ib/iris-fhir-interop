FROM containers.intersystems.com/intersystems/webgateway:2022.2.0.372.0

# apache: enable ssl
RUN a2enmod ssl
COPY default-ssl.conf /etc/apache2/sites-available/default-ssl.conf

WORKDIR /etc/apache2/sites-enabled
RUN ln -s ../sites-available/default-ssl.conf default-ssl.conf

# ssl certificate
WORKDIR /etc/ssl
COPY ssl-cert.pem /etc/ssl/certs/ssl-cert.pem
COPY ssl-cert.key /etc/ssl/private/ssl-cert.key

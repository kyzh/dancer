FROM perl:latest
MAINTAINER Florentin Raud flo@ngineered.co.uk

RUN apt-get update && \
apt-get upgrade -y && \
BUILD_PACKAGES="curl make gcc" && \
apt-get -y install $BUILD_PACKAGES --no-install-recommends && \
curl -L http://cpanmin.us | perl - Dancer2 && \
apt-get remove --purge -y curl make gcc && \
apt-get autoremove -y && \
apt-get clean && \
apt-get autoclean && \
echo -n > /var/lib/apt/extended_states && \
rm -rf /var/lib/apt/lists/* && \
rm -rf /usr/share/man/?? && \
rm -rf /usr/share/man/??_* && \
rm -rf ~/.cpanm/*

# Add git commands to allow container updating
ADD ./pull /usr/bin/pull
ADD ./push /usr/bin/push
RUN chmod 755 /usr/bin/pull && chmod 755 /usr/bin/push

# Plackup the git or local dancer app
ADD ./start.sh /start.sh
RUN chmod 755 /start.sh

# Expose Ports
EXPOSE 5000

CMD ["/bin/bash", "/start.sh"]

FROM ghcr.io/gjchentw/debian:buster

RUN	apt-get update -y && apt-get dist-upgrade -y && \
	apt-get install --no-install-recommends --no-install-suggests -y lexicon && \
	apt-get -y autoremove && apt-get -y autoclean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
	git clone --depth 1 https://github.com/dehydrated-io/dehydrated.git /srv/dehydrated && \
	wget -O- https://raw.githubusercontent.com/AnalogJ/lexicon/master/examples/dehydrated.default.sh > /srv/dehydrated/dehydrated.default.sh && \
	chmod a+x /srv/dehydrated/dehydrated.default.sh && \
	echo '0 0 * * * root sleep $(expr $(printf "%d" "0x$(hostname | md5sum | cut -c 1-8)") \% 86400);/srv/dehydrated/dehydrated --cron --hook /srv/dehydrated/dehydrated.default.sh --challenge dns-01' >> /etc/crontab && \
	touch /srv/dehydrated/domains.txt

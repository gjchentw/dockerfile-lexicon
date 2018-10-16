FROM gjchen/alpine:latest

RUN	apk --no-cache --no-progress upgrade -f && \
	apk --no-cache --no-progress add python2 curl && \
	apk --no-cache --no-progress add --virtual build-deps py2-pip git gcc python2-dev musl-dev libffi-dev openssl-dev && \
	pip install requests[security] dns-lexicon && \
	git clone --depth 1 https://github.com/lukas2511/dehydrated.git /srv/dehydrated && \
	apk del --no-progress build-deps && \
	wget -O- https://raw.githubusercontent.com/AnalogJ/lexicon/master/examples/dehydrated.default.sh > /srv/dehydrated/dehydrated.default.sh && \
	echo '0 0 * * * sleep $(expr $(printf "%d" "0x$(hostname | md5sum | cut -c 1-8)") \% 86400);/srv/dehydrated/dehydrated --cron --hook /srv/dehydrated/dehydrated.default.sh --challenge dns-01' >> /etc/crontabs/root && \
	touch /srv/dehydrated/domains.txt

	





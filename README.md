# Alpine Linux with dehydrated and lexicon installed

* [dehydrated](https://dehydrated.io)
* [lexicon](https://github.com/AnalogJ/lexicon)

Accept terms of service:
```
docker run -it -v $(pwd)/accounts:/srv/dehydrated/accounts gjchen/lexicon /srv/dehydrated/dehydrated --register --accept-terms
```

Generate:
```
docker run -it \
    -e PROVIDER=cloudflare \
    -e LEXICON_CLOUDFLARE_USERNAME=username@example.com \
    -e LEXICON_CLOUDFLARE_TOKEN=234dcef90c3d9aa0eb6798e16bdc1e4b \
    -v $(pwd)/accounts:/srv/dehydrated/accounts \
    -v $(pwd)/domains.txt:/srv/dehydrated/domains.txt \
    -v $(pwd)/certs:/srv/dehydrated/certs \
    gjchen/lexicon /srv/dehydrated/dehydrated --cron --hook /srv/dehydrated/dehydrated.default.sh --challenge dns-01
```

Start a service:
```
# daliy check and renew
docker run -d --name lexicon \
    -e PROVIDER=cloudflare \
    -e LEXICON_CLOUDFLARE_USERNAME=username@example.com \
    -e LEXICON_CLOUDFLARE_TOKEN=234dcef90c3d9aa0eb6798e16bdc1e4b \
    -v $(pwd)/accounts:/srv/dehydrated/accounts \
    -v $(pwd)/domains.txt:/srv/dehydrated/domains.txt \
    -v $(pwd)/certs:/srv/dehydrated/certs \
    gjchen/lexicon

```

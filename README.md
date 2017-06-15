## Docker-Dev ##

This is a set of Dockerfiles that build images with some helpful development tools (compilers, network utilities, editors, remote capturing and piping).

### To build and deploy all tags ###

From the root directory (where this file is located), run:

```bash
REPO="toonetown/dev"
DEFAULT="alpine"

for DIR in $(find * -name Dockerfile -exec dirname {} \;); do
  TAG="$(echo "${DIR}" | sed -e 's|/|-|g')"
  docker build --rm -t ${REPO}:${TAG} ${DIR} && docker push ${REPO}:${TAG} || break
done

for TAG in $(find * -name latest -type d -exec dirname {} \;); do
  docker tag ${REPO}:${TAG}-latest ${REPO}:${TAG} && docker push ${REPO}:${TAG} || break
done

docker tag ${REPO}:${DEFAULT} ${REPO}:latest && docker push ${REPO}:latest

```

### To run wireshark on OS X but targeting these images ###

Launch your instance with `--cap-add ALL`

From your host machine, run:

```bash
mkfifo /tmp/sharkfin && wireshark -k -i /tmp/sharkfin; rm /tmp/sharkfin
```

From your host machine in a different window, run:

```bash
docker exec -i <instance_name> /usr/bin/dumpcap -i eth0 -Ppw- -f 'ip' > /tmp/sharkfin
```

## Docker-Dev ##

This is a set of Dockerfiles that build images with some helpful development tools (compilers, network utilities, editors, remote capturing and piping).

### To build and deploy all tags ###

From the root directory (where this file is located), run:

```bash
REPO="toonetown/dev"
for DIR in $(find * -name Dockerfile -exec dirname {} \;); do
  TAG="$(echo "${DIR}" | sed -e 's|/|-|g')"
  docker build --rm -t ${REPO}:${TAG} ${DIR} && docker push ${REPO}:${TAG} || break
done
```

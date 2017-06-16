#!/bin/bash
# Script which builds a development image.  

function print_usage {
    [ -n "${1}" ] && { echo "${1}" >&2; echo "" >&2; }
    echo "Usage: ${0} [--push] [--also-tag=TAG...] [env-file]"                                          >&2
    echo ""                                                                                             >&2
    echo "Environment variables that can be used are (required marked with *):"                         >&2
    echo "  DFILE_REPO* -> The repo this image will be built against and pushed to on hub.docker.com"   >&2
    echo "                 (i.e. \"user/project\")"                                                     >&2
    echo "  DFILE_BASE* -> The base image to build against (i.e. alpine, centos, ubuntu, etc)"          >&2
    echo "  DFILE_VERS  -> The version of the base image to build against (i.e. latest, 14.04, etc)"    >&2
    echo "                 defaults to \"latest\""                                                      >&2
    echo "  DFILE_INST* -> The installation command to use (i.e. \"apk add --no-cache\" or"             >&2
    echo "                 \"apt-get update && apt-get install -yq\")"                                  >&2
    echo "  DFILE_PKGS* -> The packages to install"                                                     >&2
    echo "  DFILE_CLEAN -> A command to run to clean up packages (prefixed with \"&&\" or blank)"       >&2
    echo "                 defaults to blank"                                                           >&2
    echo ""                                                                                             >&2
    echo "A file containing these environment variables can be passed as an optional parameter to"      >&2
    echo "this script - it will be loaded prior to the execution of the script"                         >&2
    echo ""                                                                                             >&2
    echo "An optional \"--push\" parameter can be passed to this script to push the resulting build"    >&2
    echo "to hub.docker.com."                                                                           >&2
    echo ""                                                                                             >&2
    echo "You can also specify multiple \"--also-tag=TAG\" parameters which will also tag (and push,"   >&2
    echo "if you have specified \"--push\") the resulting build with an additional tag."                >&2
    echo ""                                                                                             >&2
    return 1
}

# Load parameters
DO_PUSH="no"
ALSO_TAG=()
while [ $# -gt 0 ]; do
    if [ -x "${1}" ]; then
        echo "Loading environment from ${1}..."
        . "${1}"
    else
        case "${1}" in
            "--push") DO_PUSH="yes" ;;
            "--also-tag="*) ALSO_TAG+=("$(echo "${1}" | cut -d'=' -f2)") ;;
            *) print_usage "Invalid argument ${1}"; exit $? ;;
        esac
    fi
    shift
done

# Check the required are set
for i in DFILE_REPO DFILE_BASE DFILE_INST DFILE_PKGS; do
    [ -n "${!i}" ] || { print_usage "${i} is required"; exit $?; }
done
: ${DFILE_VERS:="latest"}
: ${DFILE_CLEAN:=""}

# Build the image
cat << EOF | docker build --rm -t ${DFILE_REPO}:${DFILE_BASE}-${DFILE_VERS} -
FROM ${DFILE_BASE}:${DFILE_VERS}
MAINTAINER Nathan Toone "nathan@toonetown.com"
RUN ${DFILE_INST} ${DFILE_PKGS} ${DFILE_CLEAN}
ADD https://gist.githubusercontent.com/toonetown/cbb006b81e3e54eccbec301af9dbf7bf/raw /usr/local/bin/docker_pipe
RUN chmod 755 /usr/local/bin/docker_pipe
CMD [ "/bin/bash" ]
EOF
_R=$?; if [ ${_R} -ne 0 ]; then exit ${_R}; fi

# Run the also-tags
for i in "${ALSO_TAG[@]}"; do
    echo "Also tagging as ${i}..."
    docker tag ${DFILE_REPO}:${DFILE_BASE}-${DFILE_VERS} ${DFILE_REPO}:${i} || exit $?
done

# Run the push
if [ "${DO_PUSH}" == "yes" ]; then
    for i in "${DFILE_BASE}-${DFILE_VERS}" "${ALSO_TAG[@]}"; do
        echo "Pushing ${i}..."
        docker push ${DFILE_REPO}:${i} || exit $?
    done
fi

REPO_MIRROR_LOCATION=quay.io/<yourname>/okd-mirror

oc adm -a ${PULL_SECRET} release mirror \
  --from=${REPO_OKD_RELEASE} \
  --to=${REPO_MIRROR} \
  --to-release-image=${REPO_MIRROR_LOCATION}:${TAG}


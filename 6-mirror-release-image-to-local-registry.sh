oc adm -a ${PULL_SECRET} release mirror \
  --from=${REPO_MIRROR} \
  --to=${REPO_FINAL_MIRROR} \
  --to-release-image=${REPO_FINAL_MIRROR}:${TAG}


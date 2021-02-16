IMAGE_COUNT_TOTAL=$(cat image-shas-broken.txt | wc -l)
IMAGE_NUMBER=1

cat image-shas-broken.txt | while read line ; \
  do \
    # Bash version of 'split by character' :-)
    arrIN=(${line//;/ })
    SHA=${arrIN[0]}
    TAGNAME=${arrIN[1]}

    # We don't mirror the release image because we will recreate it later.
    if [[ "$TAGNAME" == "$TAG" ]]; then
      continue;
    fi

    # Convert image to valid format.
    printf "\n\n--------------------------------------------------------------------------------------\n"
    echo "(${IMAGE_NUMBER} of ${IMAGE_COUNT_TOTAL}): Processing image '${TAGNAME}'"
    printf "\n"

    echo "Getting image with sha: $SHA and convert it to v2s1 ..."
    skopeo copy --authfile ${PULL_SECRET} --all --format v2s1 docker://quay.io/openshift/okd-content@${SHA} dir:${SHA} 

    echo "Pushing image with sha: $SHA and tag ${TAGNAME} ..."
    skopeo copy --authfile ${PULL_SECRET} --all --format v2s2 dir:${SHA} docker://${REPO_MIRROR}:${TAGNAME}

    rm -rf ${SHA}
    IMAGE_NUMBER=$((IMAGE_NUMBER+1))
  done


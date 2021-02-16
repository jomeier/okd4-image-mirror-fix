rm -f image-shas-repaired.txt
touch image-shas-repaired.txt

IMAGE_COUNT_TOTAL=$(cat image-shas-broken.txt | wc -l)
IMAGE_NUMBER=1

cat image-shas-broken.txt | while read line ; \
  do \
    arrIN=(${line//;/ })
    SHA=${arrIN[0]}
    TAGNAME=${arrIN[1]}

    # We don't care about the old release image. Skip it.
    if [[ "$TAGNAME" == "$TAG" ]]; then
      continue;
    fi

    # Get sha of fixed image.
    echo "#${IMAGE_NUMBER}/${IMAGE_COUNT_TOTAL}: Getting digest of fixed image: $TAGNAME ..."
    NEW_SHA=$(skopeo inspect --authfile ${PULL_SECRET} docker://${REPO_MIRROR}:${TAGNAME} | jq .Digest | sed 's/\"//g')

    echo "${NEW_SHA};${TAGNAME}"  >> image-shas-repaired.txt

    IMAGE_NUMBER=$(($IMAGE_NUMBER + 1))
  done


BASE_IMAGE=$(cat base-image-sha.txt)

rm -f image-replacements.txt
touch image-replacements.txt

cat image-shas-repaired.txt | while read line ; \
  do \
    arrIN=(${line//;/ })
    SHA=${arrIN[0]}
    TAGNAME=${arrIN[1]}
    IMAGE_NAME=$(echo ${TAGNAME} | sed "s/${TAG}-//g")

    printf "${IMAGE_NAME}=${REPO_MIRROR}@${SHA} " >> image-replacements.txt
  done

IMAGE_REPLACEMENTS=$(cat image-replacements.txt)
oc adm release new --registry-config ${PULL_SECRET} --from-release ${REPO_OKD_RELEASE} ${IMAGE_REPLACEMENTS} --to-image ${REPO_MIRROR}:${TAG} --to-image-base=${BASE_IMAGE}


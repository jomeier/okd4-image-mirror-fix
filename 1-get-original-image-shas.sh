printf "\n"
echo "Get Digests of all images in Release '${REPO_OKD_RELEASE}'."
echo "I use a dry run of 'oc adm release mirror' that doesn't mirror anything for this task."
printf "\n"

rm -f image-shas-broken.txt
rm -f mirror.log

# Only a mirror dry run. Doesn't really mirror anything.
oc adm -a ${PULL_SECRET} release mirror \
  --from=${REPO_OKD_RELEASE} \
  --to=${REPO_MIRROR} \
  --to-release-image=${REPO_MIRROR}:${TAG} --dry-run |& tee -a mirror.log

cat mirror.log | grep "      sha256:" > image-shas-broken.txt
sed -i 's#      ##g' image-shas-broken.txt
sed -i 's# -> #;#' image-shas-broken.txt


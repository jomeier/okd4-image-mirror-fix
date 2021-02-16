rm -f base-image-sha.txt

# All release images seem to be based on the cluster-version-operator image.
# Get the digest of it.
CLUSTER_VERSION_OPERATOR=$(cat image-shas-repaired.txt | grep cluster-version-operator) 

# Get sha of CSV.
arrIN=(${CLUSTER_VERSION_OPERATOR//;/ })
SHA=${arrIN[0]}
#TAGNAME=${arrIN[1]}

echo "${REPO_MIRROR}@${SHA}" > base-image-sha.txt


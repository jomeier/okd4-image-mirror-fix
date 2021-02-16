# Location of your docker pull secret to your registrie(s) in docker json format.
# Simply login to your registry and set PULL_SECRET to ~/.docker/config.json
PULL_SECRET=~/.docker/config.json

# Select the OKD4 release image from: https://origin-release.apps.ci.l2s4.p1.openshiftapps.com
REPO_OKD_RELEASE=quay.io/openshift/okd:4.6.0-0.okd-2021-01-23-132511

# A repository where the fixed images will be stored.
REPO_MIRROR=quay.io/<YOUR NAME>/okd

# 
TAG=4.6.0-0.okd-2021-01-23-132511


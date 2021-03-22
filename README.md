# okd4-image-mirror-fix

THIS FIX IS NOT SUPPOSED TO BE USED ON OKD 4.7+ !!!

## Prerequisite
* install the oc client
* install skopeo

Nothing special about that.

## Call scripts and fix the broken OKD4 release images 
Setup your repositories, OKD4 versions and tags in 0-variables.sh

Start fixing your images and create a new release image with fixed images, mirror it afterwards.

I'm not sure if it is really necessary to mirror the images after we created a completely new release image.

```
source ./0-variables.sh
source ./1-get-original-image-shas.sh
source ./2-fix-images.sh
source ./3-get-fixed-shas.sh
source ./4-get-sha-of-base-image.sh
source ./5-create-new-release-image.sh
source ./6-mirror-release-image-to-local-registry.sh
```
## OKD 4.5 to 4.6 upgrade

If you want to upgrade from version: 2020-10-15 to version 2021-01-23 you must do this on all (!) nodes of your OKD 4.5 cluster:

```
ssh core@<node>
sudo su -

# Disable all repos before upgrading the cluster from 4.5 to 4.6.
grep enabled=1 /etc/yum.repos.d/*
find /etc/yum.repos.d/ -type f -exec sudo sed -i 's/enabled=1/enabled=0/g' {} +
grep enabled=1 /etc/yum.repos.d/*

reboot
```

Afterwards you should be able to upgrade.

## Add new node to 4.6 cluster if you previously were on 4.5-2020-10-15

Adding a new node to a cluster that you previously upgraded from 4.5-2020-10-15 must be done this way:
- create a self signed cert with your api-int.<cluster name>.<domain> in the SAN field
- add this certificate and its key to this secret: openshift-machine-config-operator/machine-config-server-tls
- and more ... TODO ...





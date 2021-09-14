#!/bin/ash

set -e
#workaround for azure DNS issue
if [ -n "$MESOS_CONTAINER_NAME"  ]; then 
  echo "search marathon.l4lb.thisdcos.directory" >> /etc/resolv.conf;
fi
sed -i "s/VILKKU_BASIC_AUTH/${VILKKU_BASIC_AUTH}/" /etc/nginx/external.conf
sed -i "s/JOJO_BASIC_AUTH/${JOJO_BASIC_AUTH}/" /etc/nginx/external.conf
sed -i "s/LAPPEENRANTA_BASIC_AUTH/${LAPPEENRANTA_BASIC_AUTH}/" /etc/nginx/external.conf
sed -i "s/LINKKI_BASIC_AUTH/${LINKKI_BASIC_AUTH}/" /etc/nginx/external.conf
sed -i "s/NEW_LISSU_BASIC_AUTH/${NEW_LISSU_BASIC_AUTH}/" /etc/nginx/external.conf
sed -i "s/transitdatadev/${HSL_RT_STORAGE_NAME}/" /etc/nginx/common.conf
sed -i "s/LAHTI_BASIC_AUTH/${LAHTI_BASIC_AUTH}/" /etc/nginx/external.conf
sed -i "s/HAMEENLINNA_BASIC_AUTH/${HAMEENLINNA_BASIC_AUTH}/" /etc/nginx/external.conf
sed -i "s/dev.hslfi.hsldev.com/${NEW_HSL_FI_URL}/" /etc/nginx/nginx.conf
sed -i "s/LMJ_BASIC_AUTH/${LMJ_BASIC_AUTH}/" /etc/nginx/external.conf
sed -i "s/MIKKELI_BASIC_AUTH/${MIKKELI_BASIC_AUTH}/" /etc/nginx/external.conf
sed -i "s/VAASA_BASIC_AUTH/${VAASA_BASIC_AUTH}/" /etc/nginx/external.conf
sed -i "s/SALO_BASIC_AUTH/${SALO_BASIC_AUTH}/" /etc/nginx/external.conf
sed -i "s/KOUVOLA_BASIC_AUTH/${KOUVOLA_BASIC_AUTH}/" /etc/nginx/external.conf
sed -i "s/PERILLE_BASIC_AUTH/${PERILLE_BASIC_AUTH}/" /etc/nginx/external.conf

#start nginx
nginx

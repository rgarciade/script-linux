#!/bin/bash
# -*- ENCODING: UTF-8 -*-

echo 'instalando envio de emails::'
echo '1ºsu servidor de envio:'
read SERVIDOR
echo ${SERVIDOR}
echo '1.1ºpuerto de envio:'
read PUERTO
echo ${PUERTO}
echo '2ºsu usuario/email:'
read USUARIO
echo ${USUARIO}
echo '3ºsu contraseña:'
read CONTRASENA

echo 'updateando...'
apt-get update

echo 'instalando ssmtp'
apt-get install ssmtp

array=(${SERVIDOR//./ })

for i in "${!array[@]}"
do
   
      if (( $i > 0 ));
      then
        if (( $i > 1 ));
            then
                DOMAIN="$DOMAIN.${array[i]}"  
            else
                DOMAIN="${array[i]}"  
            fi
        fi
done
echo "${DOMAIN}"

echo 'configurando archivos'
echo "# Config file for sSMTP sendmail
#
# The person who gets all mail for userids < 1000
# Make this empty to disable rewriting.
#root=postmaster
root=$USUARIO

# The place where the mail goes. The actual machine name is required no
# MX records are consulted. Commonly mailhosts are named mail.domain.com
#mailhub=mail
mailhub=$SERVIDOR:$PUERTO

AuthUser=$USUARIO
AuthPass=$CONTRASENA
UseTLS=YES
UseSTARTTLS=YES

# Where will the mail seem to come from?
#rewriteDomain=
rewriteDomain=$DOMAIN

# The full hostname
#hostname=MyMediaServer.home
hostname=$USUARIO

# Are users allowed to set their own From: address?
# YES - Allow the user to specify their own From: address
# NO - Use the system generated From: address
FromLineOverride=YES" > /etc/ssmtp/ssmtp.conf

echo "# sSMTP aliases
#
# Format: local_account:outgoing_address:mailhub
#
# Example: root:your_login@your.domain:mailhub.your.domain[:port]
# where [:port] is an optional port number that defaults to 25.
root:$USUARIO:$SERVIDOR:$PUERTO" > /etc/ssmtp/revaliases
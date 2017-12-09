until nc -z -v -w30 mysql 3306
do
  echo "Waiting for database connection..."
  # wait for 5 seconds before check again
  sleep 5
done
opensipsdbctl create 
opensipsctl add 700@127.0.0.1 700p
opensipsctl add 800@127.0.0.1 800p
service rsyslog start
/usr/local/sbin/opensipsctl start
HOST_IP=$(ip route get 8.8.8.8 | head -n +1 | tr -s " " | cut -d " " -f 7)
sed -i "s/listen=.*/listen=udp:${HOST_IP}:5060/g" /usr/local/etc/opensips/opensips.cfg
tail -f /var/log/opensips.log


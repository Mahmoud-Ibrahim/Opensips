pub_ip=$(curl ifconfig.co) 
HOST_IP=$(ip route get 8.8.8.8 | head -n +1 | tr -s " " | cut -d " " -f 7)
rtpproxy -F -f -l $pub_ip -s udp:$HOST_IP:12221  -d DBUG -u rtpproxy

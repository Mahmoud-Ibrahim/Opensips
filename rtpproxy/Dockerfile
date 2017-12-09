#FROM alpine
FROM debian:jessie
RUN apt-get update -qq && apt-get install -y build-essential \
git bison flex m4 pkg-config libncurses5-dev rsyslog 
RUN apt-get install sqlite -y
RUN git clone  -b master https://github.com/sippy/rtpproxy.git
RUN git -C rtpproxy submodule update --init --recursive
RUN cd rtpproxy  && ./configure && make && make install
run adduser --system rtpproxy 
RUN apt-get update -qq && apt-get install curl -y
#RUN echo -e "local0.* -/var/log/opensips.log\n& stop" > /etc/rsyslog.d/opensips.conf
#RUN touch /var/log/opensips.log

EXPOSE 12221/udp
#copy opensips.cfg /etc/opensips/opensips.cfg
#cmd service rsyslog start
#cmd /usr/local/sbin/opensipsctl start
#cmd tail -f /var/log/opensips.log
#cmd rtpproxy -F -f -s udp:0.0.0.0:12221  -d DBUG -u rtpproxy
copy ./run_rtppproxy.sh /run_rtppproxy.sh
#cmd run_rtppproxy.sh
ENTRYPOINT ["bash","/run_rtppproxy.sh"]

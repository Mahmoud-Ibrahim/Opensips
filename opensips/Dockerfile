FROM debian:jessie
RUN apt-get update -qq && apt-get install -y build-essential \
git bison flex m4 pkg-config libncurses5-dev rsyslog  perl libdbi-perl libdbd-mysql-perl libdbd-pg-perl libfrontier-rpc-perl libterm-readline-gnu-perl libberkeleydb-perl sqlite
RUN apt-get update -qq && apt-get install -y vim netcat
RUN apt-get update -qq && apt-get install -y mysql-client libmysqlclient-dev

RUN git clone https://github.com/OpenSIPS/opensips.git -b 2.3  opensips_2.3
#RUN cd opensips_2.3 && sed -i -e 's/exclude_modules/\#exclude_modules/g' Makefile.conf.template
RUN cd opensips_2.3  && make all include_modules="db_mysql"   && FASTER=1 make -j4 install   include_modules="db_mysql"
RUN echo -e "local0.* -/var/log/opensips.log\n& stop" > /etc/rsyslog.d/opensips.conf
RUN touch /var/log/opensips.log
#CACHE OFF
EXPOSE 5060/udp
copy ./opensips.cfg  /usr/local/etc/opensips/opensips.cfg
copy ./opensipsctlrc   /usr/local/etc/opensips/opensipsctlrc
copy ./osipsconsolerc /usr/local/etc/opensips/osipsconsolerc
copy ./start.sh	/start.sh	
run ls /start.sh
#run opensipsdbctl create 
#run opensipsctl add 700 700p
#run opensipsctl add 800 800p
#cmd service rsyslog start
#cmd /usr/local/sbin/opensipsctl start
#cmd tail -f /var/log/opensips.log
ENTRYPOINT ["bash","/start.sh"]

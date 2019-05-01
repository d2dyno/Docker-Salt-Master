#
# Salt Stack Salt Master Container
#

FROM ubuntu:18.04
MAINTAINER lamaral <email@lamaral.com.br>
ENV TZ=America/Chicago

# Update System
RUN apt-get update && apt-get upgrade -y -o DPkg::Options::=--force-confold
# Set timezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Add PPA

RUN apt-get install -y software-properties-common dmidecode apt-utils wget
RUN wget -O - https://repo.saltstack.com/py3/ubuntu/18.04/amd64/2018.3/SALTSTACK-GPG-KEY.pub | apt-key add -
RUN echo "deb https://repo.saltstack.com/py3/ubuntu/18.04/amd64/2018.3 bionic main" > /etc/apt/sources.list.d/saltstack.list
RUN apt-get update

# Install Salt

RUN apt-get install -y salt-master

# Volumes

VOLUME ['/etc/salt/pki', '/var/cache/salt', '/var/logs/salt', '/etc/salt/master.d', '/srv/salt']

# Add Run File

ADD run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Ports

EXPOSE 4505 4506

# Run Command

CMD "/usr/local/bin/run.sh"

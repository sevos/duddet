FROM base

RUN apt-get update
RUN apt-get install -y git-core build-essential
RUN apt-get install -y python-pip python-dev libevent-dev
RUN git clone git://github.com/dotcloud/docker-registry.git /docker-registry
RUN cd /docker-registry && pip install -r requirements.txt
RUN cp /docker-registry/config_sample.yml /docker-registry/config.yml
RUN mkdir /tmp/registry
CMD cd /docker-registry && gunicorn --access-logfile - --debug -k gevent -b 0.0.0.0:5000 -w 1 wsgi:application

EXPOSE 5000:5000

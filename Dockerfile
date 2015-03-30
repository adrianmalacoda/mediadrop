FROM debian:stable
MAINTAINER Adrian Malacoda <adrian.malacoda@monarch-pass.net>

RUN apt-get -y update && apt-get -y install libjpeg-dev zlib1g-dev \
    libfreetype6-dev libmysqlclient-dev python-dev python-setuptools \
    git build-essential
    
ADD mediadrop /mediadrop/mediadrop
ADD requirements.txt /mediadrop/requirements.txt
ADD requirements.py26.txt /mediadrop/requirements.py26.txt
ADD setup.cfg /mediadrop/setup.cfg
ADD setup.py /mediadrop/setup.py
ADD setup_triggers.sql /mediadrop/setup_triggers.sql
ADD mediacore /mediadrop/mediacore
ADD data /mediadrop/data.default
ADD deployment-scripts /mediadrop/deployment-scripts
ADD development.ini /mediadrop/development.ini
ADD doc /mediadrop/doc
ADD alembic.ini /mediadrop/alembic.ini
ADD batch-scripts /mediadrop/batch-scripts
ADD MANIFEST.in /mediadrop/MANIFEST.in
ADD start /mediadrop/start

WORKDIR /mediadrop

RUN chmod +x start && python setup.py develop && \
    paster make-config MediaDrop deployment.ini

EXPOSE 8080
CMD ["/mediadrop/start"]

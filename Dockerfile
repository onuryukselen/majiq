FROM nfcore/base
LABEL author="onur.yukselen@umassmed.edu" description="Docker image containing all requirements for the dolphinnext/majiq pipeline"

COPY environment.yml /
RUN conda env create -f /environment.yml && conda clean -a
RUN apt-get clean all
RUN apt-get update
RUN apt-get dist-upgrade -y
RUN apt-get -y install zip unzip gcc g++ make python3 python3-dev python3-pip zlib1g-dev zlibc libbz2-dev liblzma-dev

#################
## majiq 2.0 ##
#################
RUN export LC_ALL=C
RUN pip3 install numpy scipy biopython

RUN cd /tmp
RUN wget "https://github.com/samtools/htslib/releases/download/1.9/htslib-1.9.tar.bz2"
RUN tar -vxjf htslib-1.9.tar.bz2
RUN cd htslib-1.9 && make && make install

RUN pip3 install virtualenv awscli
RUN pip3 install pip
RUN pip3 install wheel setuptools
RUN pip3 install cython numpy GitPython
RUN pip3 install git+https://bitbucket.org/biociphers/majiq_stable.git#egg=majiq


RUN mkdir -p /project /nl /mnt /share

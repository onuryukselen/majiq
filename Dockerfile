FROM nfcore/base
LABEL author="onur.yukselen@umassmed.edu" description="Docker image containing all requirements for the dolphinnext/majiq pipeline"

COPY environment.yml /
RUN conda env create -f /environment.yml && conda clean -a
RUN apt-get clean all
RUN apt-get update
RUN apt-get dist-upgrade -y
RUN apt-get -y install zip unzip gcc g++ make python3 python3-dev python3-pip zlib1g-dev zlibc libbz2-dev liblzma-dev

#################
## majiq 11x ##
#################
RUN export LC_ALL=C
RUN cd /tmp
RUN wget "https://github.com/samtools/htslib/releases/download/1.9/htslib-1.9.tar.bz2"
RUN tar -vxjf htslib-1.9.tar.bz2
RUN cd htslib-1.9 && make && make install

RUN pip3 install virtualenv awscli
RUN pip3 install pip
RUN pip3 install wheel setuptools
RUN pip3 install cython pysam numpy GitPython scipy==1.1.0
RUN pip3 install git+https://bitbucket.org/biociphers/majiq_stable.git@majiq_11x#egg=majiq_11x

RUN mkdir -p /project /nl /mnt /share

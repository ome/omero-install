# Dockerfile for testing the OMERO Linux installation instructions
# Not intended for production use
# Note to enable systemd this must be run with on a host with systemd
# and additional flaks, see the omero-ssh-c7 README
FROM centos:centos8
MAINTAINER ome-devel@lists.openmicroscopy.org.uk

ENV container docker
ENV LANG en_US.UTF-8
ENV PATH /opt/conda/bin:$PATH
ARG PATH /opt/conda/bin:$PATH
RUN yum install -y langpacks-en glibc-all-langpacks

RUN yum install -y sudo openssh-server openssh-clients && \
    yum clean all

RUN systemctl enable sshd.service

# Workaround to enable ssh logins
RUN sed -i \
    's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' \
    /etc/pam.d/sshd

# To avoid error: sudo: sorry, you must have a tty to run sudo
RUN sed -i -e "s/Defaults    requiretty.*/ #Defaults    requiretty/g" /etc/sudoers

RUN useradd omero && \
    echo 'omero:omero' | chpasswd && \
    echo "omero ALL= (ALL) NOPASSWD: ALL" >> /etc/sudoers.d/omero

# Workaround as there is no need for udev or getty in containers.
# see https://bugzilla.redhat.com/show_bug.cgi?id=1046469#c11
RUN rm -rf /lib/systemd/system/systemd*udev* ; \
    rm -f /lib/systemd/system/getty.target;

# Shutdown systemd in container correctly
STOPSIGNAL "RTMIN+3"


# Remove the existing omero user
RUN userdel -r omero && \
    rm -f /etc/sudoers.d/omero && \
    echo 'root:omero' | chpasswd

ADD omero-install-test.zip /
RUN yum -y install initscripts unzip wget && unzip omero-install-test.zip

RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir -p /opt \
    && bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda \
    && rm -f Miniconda3-latest-Linux-x86_64.sh \
    && ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh \
    && echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc
RUN conda --version

# This is so that scripts can detect whether they're in docker
RUN echo 'export container=docker' > /etc/profile.d/docker.sh

ARG OMEROVER=latest
ARG JAVAVER=openjdk11
ARG ICEVER=ice36
ARG PGVER=pg11

RUN cd omero-install-test && \
    bash install_centos8.sh

EXPOSE 22 80 4063 4064

# This will automatically start systemd
CMD ["/usr/sbin/init"]

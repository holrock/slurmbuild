FROM centos:centos7.3.1611
RUN yum groupinstall -y "Development Tools" && \
    yum install -y gcc gcc-c++ rpm-build bzip2-devel \
    openssl-devel zlib-devel readline-devel pam-devel perl-ExtUtils-MakeMaker \
    mysql-server mysql-devel \
    && rm -rf /var/cache/yum/* \
    && yum clean all
COPY /workdir/RPMS/x86_64/munge-*.rpm /root/
RUN rpm -i /root/munge-*.rpm
ARG SLURM
ENV SLURM ${SLURM}
CMD rpmbuild --define "_topdir /workdir" -ta /workdir/${SLURM}.tar.bz2
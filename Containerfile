FROM docker.io/library/centos:centos7

COPY rpms/* /tmp

RUN sed -i 's/override_install_langs=en_US.UTF-8//' /etc/yum.conf &&\
    yum reinstall -y glibc-common &&\
    yum update -y &&\
    yum install -y epel-release &&\
    yum install -y bash-completion dnf dnf-plugins-core fedpkg findutils git python3 python3-devel python3-rpm-macros rpmdevtools vim-enhanced wget &&\
    yum install -y /tmp/*.rpm &&\
    find /root/ -type f | egrep 'anaconda-ks.cfg|anaconda-post-nochroot.log|anaconda-post.log|original-ks.cfg' | xargs rm -f &&\
    find / -mindepth 1 -type f | egrep 'anaconda-ks.cfg|anaconda-post-nochroot.log|anaconda-post.log|original-ks.cfg' | xargs rm -f &&\
    echo "defaultyes=True" >> /etc/dnf/dnf.conf &&\
    mkdir /root/.bashrc.d &&\
    cp /etc/rpkg.conf /etc/rpkg.conf.orig &&\
    find /tmp/ -mindepth 1 | xargs rm -rf

COPY files/bashrc /root/.bashrc
COPY files/bashrc-default /root/.bashrc.d/default
COPY files/bashrc-fedpkg /root/.bashrc.d/fedpkg
COPY files/bashrc-rpmbuild /root/.bashrc.d/rpmbuild
COPY files/lang.sh /etc/profile.d
COPY files/rpmmacros /root/.rpmmacros
COPY files/rpkg.conf /etc/rpkg.conf

# set login directory
WORKDIR /root

CMD ["/bin/bash"]

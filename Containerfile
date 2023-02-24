FROM registry.centos.org/centos:7

COPY rpms/* /tmp

RUN yum update -y &&\
    yum install -y epel-release &&\
    yum install -y bash-completion dnf dnf-plugins-core fedpkg git rpmdevtools findutils git python3 python3-devel python3-rpm-macros vim-enhanced wget &&\
    yum install -y /tmp/rpkg-3.2-3.el7.noarch.rpm /tmp/python36-munch-2.3.2-3.el7.noarch.rpm &&\
    find /root/ -type f | egrep 'anaconda-ks.cfg|anaconda-post-nochroot.log|anaconda-post.log|original-ks.cfg' | xargs rm -f &&\
    echo "defaultyes=True" >> /etc/dnf/dnf.conf &&\
    mkdir /root/.bashrc.d &&\
    cp /etc/rpkg.conf /etc/rpkg.conf.orig &&\
    find /tmp/ -mindepth 1 | xargs rm -rf

COPY files/bashrc /root/.bashrc
COPY files/bashrc-default /root/.bashrc.d/default
COPY files/bashrc-rpmbuild /root/.bashrc.d/rpmbuild
COPY files/lang.sh /etc/profile.d
COPY files/rpmmacros /root/.rpmmacros
COPY files/rpkg.conf /etc/rpkg.conf

# set login directory
WORKDIR /root

CMD ["/bin/bash"]

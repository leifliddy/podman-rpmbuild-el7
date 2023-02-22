FROM registry.centos.org/centos:7

RUN yum update -y &&\
    yum install -y bash-completion dnf dnf-plugins-core epel-release git rpmdevtools findutils git python3-rpm-macros.noarch vim-enhanced wget &&\
    find /root/ -type f | egrep 'anaconda-ks.cfg|anaconda-post-nochroot.log|anaconda-post.log|original-ks.cfg' | xargs rm -f &&\
    echo "defaultyes=True" >> /etc/dnf/dnf.conf &&\
    mkdir /root/.bashrc.d

COPY files/bashrc /root/.bashrc
COPY files/bashrc-default /root/.bashrc.d/default
COPY files/bashrc-rpmbuild /root/.bashrc.d/rpmbuild
COPY files/rpmmacros /root/.rpmmacros

# set login directory
WORKDIR /root

CMD ["/bin/bash"]

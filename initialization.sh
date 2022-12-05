echo "close GUI"
systemctl set-default multi-user.target

echo "close firewalld"
systemctl stop firewalld
systemctl disable firewalld

echo close SELinux
now_second=`date +'%s'`
mv /etc/selinux/config /etc/selinux/config.$now_second

cat << EOF > /etc/selinux/config
SELINUX=disabled
SELINUXTYPE=targeted
EOF

echo "close avahi-daemon"
systemctl stop avahi-daemon
systemctl disable avahi-daemon

echo "delete virbr0 virtual network card"
ifconfig virbr0 down
brctl delbr virbr0

echo "disable & mask libvirtd"
systemctl disable libvirtd.service
systemctl mask libvirtd.service

echo "install rlwrap"
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install -y rlwrap

echo install Oracle preinstall
yum -y localinstall oracle-database-preinstall-19c-1.0-1.el7.x86_64.rpm
echo install Oracle preinstall done

passwd oracle << EOF
oracle
oracle
EOF

echo "user(oracle, grid) sudo"
chmod u+w /etc/sudoers

cat << EOF >> /etc/sudoers
oracle  ALL=(ALL)       NOPASSWD: NOPASSWD: ALL
grid    ALL=(ALL)       NOPASSWD: NOPASSWD: ALL
EOF

chmod u-w /etc/sudoers

echo "Install VIM"
yum install -y vim

ln -s /usr/bin/vim /usr/local/bin/vi

echo "config vim" 
if [ ! -f ~/.vimrc ]; then
    cp -rf ./vimrc ~/.vimrc
fi

profile_size=`ls -l ~/.bash_profile | awk '{print $5}'`
if [ $profile_size -lt 200 ]; then
    unalias cp
    cp -rf ./bash_profile.sh ~/.bash_profile
fi



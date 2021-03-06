ulyaothos=`cat /etc/ulyaoth`

useradd ulyaoth
su ulyaoth -c "rpmdev-setuptree"
cd /home/ulyaoth/rpmbuild/SPECS/

su ulyaoth -c "wget https://raw.githubusercontent.com/ulyaoth/repository/master/ulyaoth-msktutil/SPECS/ulyaoth-msktutil.spec -O /home/ulyaoth/rpmbuild/SPECS/ulyaoth-msktutil.spec"

if type dnf 2>/dev/null
then
  dnf builddep -y ulyaoth-msktutil.spec
elif type yum 2>/dev/null
then
  yum-builddep -y ulyaoth-msktutil.spec
fi

su ulyaoth -c "spectool /home/ulyaoth/rpmbuild/SPECS/ulyaoth-msktutil.spec -g -R"
su ulyaoth -c "rpmbuild -ba /home/ulyaoth/rpmbuild/SPECS/ulyaoth-msktutil.spec"

if [ "$ulyaothos" == "amazonlinux" ]
then
  cp /home/ulyaoth/rpmbuild/SRPMS/* /home/ec2-user/
  cp /home/ulyaoth/rpmbuild/RPMS/x86_64/* /home/ec2-user/
  cp /home/ulyaoth/rpmbuild/RPMS/i686/* /home/ec2-user/
  cp /home/ulyaoth/rpmbuild/RPMS/i386/* /home/ec2-user/
  cp /home/ulyaoth/rpmbuild/RPMS/noarch/* /home/ec2-user/
else
  cp /home/ulyaoth/rpmbuild/SRPMS/* /root/
  cp /home/ulyaoth/rpmbuild/RPMS/x86_64/* /root/
  cp /home/ulyaoth/rpmbuild/RPMS/i686/* /root/
  cp /home/ulyaoth/rpmbuild/RPMS/i386/* /root/
  cp /home/ulyaoth/rpmbuild/RPMS/noarch/* /root/
fi

rm -rf /root/build-ulyaoth-*
rm -rf /home/ulyaoth/rpmbuild
#!/bin/sh
#
# Copyright (c) 2012-2013 Konstantin Dmitriev
#
# How to build:
# mount -o bind /home/zelgadis/projects/morevna/repo_new2/remake /mnt/data/buildroots/pencil-buildroot.i386/mnt/
# linux32 chroot /mnt/data/buildroots/pencil-buildroot.i386/
# apt-get install --force-yes -y rpm alien
# cd /mnt
# bash util/remake-package.sh
# exit
# umount /mnt/data/buildroots/pencil-buildroot.i386/mnt/

export EMAIL='ksee.zelgadis@gmail.com'
export VERSION='0.5'
export RELEASE='1'
export SCRIPTDIR=$(cd `dirname $0`; pwd)
export SOURCEDIR=`dirname "$SCRIPTDIR"`

cat > /tmp/remake.spec << EOF
%define _unpackaged_files_terminate_build 0

Name:           remake
Version:        $VERSION
Release:        $RELEASE
Summary: 		Utility that helps you render complex animation projects.
Group: 			Applications/Multimedia
License:        GPL
URL:            http://github.com/morevnaproject/remake
BuildArch:		noarch
BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
Requires:		xterm make


%description
Complex animation project is usualy consist of several scenes and their content located in many files, which are dependent one to another. When some file is modified it\'s often hard to determine what should to be re-rendered to keep the project up to date. Remake takes care about tracking dependencies between changed files and automaticaly re-renders sources of animation affected by the change.

%prep


%build

%install
rm -rf \$RPM_BUILD_ROOT

cd $SOURCEDIR
./install-remake \$RPM_BUILD_ROOT/usr/

%check
exit 0

%clean
rm -rf \$RPM_BUILD_ROOT

%post

%postun

%files
%defattr(-,root,root,-)
/usr/bin/*
/usr/lib/*
/usr/share/*

%changelog
* Wed Jan 02 2013 Konstantin Dmitriev <ksee.zelgadis@gmail.com> - 0.5-1
- Release version 0.5

* Wed Jan 11 2012 Konstantin Dmitriev <ksee.zelgadis@gmail.com> - 0.4-0.beta
- Initial release

EOF
	
	rpmbuild -bb --target noarch /tmp/remake.spec
	rm /tmp/remake.spec
	cp /root/rpmbuild/RPMS/noarch/remake-${VERSION}-${RELEASE}.noarch.rpm .
    alien -k --scripts remake-${VERSION}-${RELEASE}.noarch.rpm
    rm -rf remake-${VERSION}

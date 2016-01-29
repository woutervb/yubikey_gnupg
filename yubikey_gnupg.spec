Name:		yubikey_gnupg
Version:	0.2
Release:	1%{?dist}
Summary:	This package will install tools to use yubikey with gnupg
Group:		System Environment/Deamons
License:	GPLv2+
BuildArch:	noarch
URL:		https://github.com/woutervb/yubikey_gnupg
Source0:	https://github.com/woutervb/yubikey_gnupg/archive/%{version}.tar.gz


#BuildRequires:	
Requires:	gnupg2-smime
Requires:	ykpers

%description

%prep
%autosetup -n yubikey_gnupg-%{version}

%build

%install 
mv etc $RPM_BUILD_ROOT%{_sysconfdir}

%files
%defattr(-,root,root,-)
%config(noreplace) %{_sysconfdir}/profile.d/gnupg-agent-wrapper.sh
%config(noreplace) %{_sysconfdir}/udev/rules.d/70-u2f.rules

%post -p "/bin/sh"
/usr/bin/udevadm control --reload-rules


%changelog
* Fri Jan 29 2016 Wouter van Bommel <wouter@vanbommelonline.nl>
- trigger reload of udev rules
- add dependency on ykpers
* Wed Jan 21 2015 Wouter van Bommel <wouter@vanbommelonline.nl>
- First creation of the package

%undefine _debugsource_packages

Name:		lab
Version:	0.25.1
Release:	1
Summary:	Command line tool for working with gitlab repositories
Source0:	https://github.com/zaquestion/lab/archive/refs/tags/v%{version}.tar.gz
Source1:	godeps-for-lab-%{version}.tar.zst
# Used to create Source 1, not actually used while building the package
Source1000:	package-source.sh
Group:		Development/Tools
License:	CC0-1.0-Universal
BuildRequires:	golang
BuildRequires:	make

%description
Command line tool for working with gitlab repositories

%prep
%autosetup -p1 -a1

%build
export GOPATH=$(pwd)/.godeps
%make_build

%install
mkdir -p %{buildroot}%{_bindir}
install -c -m 755 lab %{buildroot}%{_bindir}/

%files
%{_bindir}/lab

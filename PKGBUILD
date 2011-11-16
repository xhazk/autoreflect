# Autoreflect-git
# Maintainer: xhazk <xhazzk<@>gmail*com)

pkgname=autoreflect-git
pkgver=20111116
pkgrel=1
pkgdesc="Autoreflect automates the process of generating an optimized mirrorlist"
arch=('i686' 'x86_64')
license=('GPL')
depends=('reflector')
makedepends=('git' 'cmake' 'pkgconfig')

_gitroot="git://github.com/xhazk/autoreflect.git"
_gitname="autoreflect"

build() {
  cd "$srcdir"
  msg "Connecting to GIT server...."

  if [ -d $_gitname ] ; then
    cd $_gitname && git pull origin
    msg "The local files are updated."
  else
    git clone $_gitroot
  fi

  msg "GIT checkout done or server timeout"

  cd "$srcdir/$_gitname"
  cp README.cmake README || return 1
  cd "$srcdir/"

  msg "Starting configuration"

  #CONFIGURE HERE
  [ ! -d "$_gitname-build" ] || rm -r "$_gitname-build" || return 1
  mkdir "$_gitname-build" || return 1
  cd "$_gitname-build"
  ccmake "../$_gitname/" || return 1

  # BUILD HERE
  msg "Starting make..."
  make || return 1
  make DESTDIR="$pkgdir" install
} 

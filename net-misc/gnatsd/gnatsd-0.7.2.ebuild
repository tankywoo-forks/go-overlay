# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

GOLANG_PKG_IMPORTPATH="github.com/nats-io"
GOLANG_PKG_ARCHIVEPREFIX="v"
GOLANG_PKG_HAVE_TEST=1

# Declares dependencies
GOLANG_PKG_DEPENDENCIES=(
	"github.com/golang/crypto:1f22c01 -> golang.org/x"

	# Unit regression tests
	"github.com/nats-io/nats:574d117d50" # v1.0.9
)

inherit golang-single

DESCRIPTION="A high Performance NATS Server written in GoLang"
HOMEPAGE="https://nats.io"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86 arm"

src_test() {
	if has sandbox $FEATURES && has network-sandbox $FEATURES; then
		eerror "Some tests require sandbox, and network-sandbox to be disabled in FEATURES."
	fi

	golang-single_src_test
}

# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

GOLANG_PKG_IMPORTPATH="github.com/oleiade"
GOLANG_PKG_VERSION="3461cb35c1309d7b315609d22a84cdc7c7bdd329"
GOLANG_PKG_BUILDPATH="/cmd/${PN}"
GOLANG_PKG_HAVE_TEST=1

inherit golang-single bash-completion-r1

DESCRIPTION="A networked and encrypted key-value database."
HOMEPAGE="https://${GOLANG_PKG_IMPORTPATH}/${PN}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc bash-completion zsh-completion fish-completion"

DEPEND="doc? ( dev-python/sphinx )
	bash-completion? ( >=app-shells/bash-completion-2.0 )
	zsh-completion? ( app-shells/gentoo-zsh-completions )
	fish-completion? ( app-shells/fish )"

RESTRICT+=" test"

src_install() {
	golang-single_src_install

	# Install documentation
	if use doc; then
		pushd "${S}"/docs > /dev/null || die
			emake singlehtml
			docinto html
			dodoc -r build/singlehtml/*
		popd > /dev/null || die
	fi

	# Install autocompletion helpers
	use bash-completion && newbashcomp scripts/autocompletion/autocompletion.bash ${PN}
	if use zsh-completion ; then
		insinto /usr/share/zsh/site-functions
		newins scripts/autocompletion/autocompletion.zsh _${PN}
	fi
	if use fish-completion ; then
		insinto /usr/share/fish/completions
		newins scripts/autocompletion/autocompletion.fish ${PN}.fish
	fi
}

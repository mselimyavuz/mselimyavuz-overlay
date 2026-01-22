# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3 xdg toolchain-funcs

DESCRIPTION="Advanced Audio Plugin Host (VST/AU/LV2) by Kushview"
HOMEPAGE="https://kushview.net/element/"
EGIT_REPO_URI="https://github.com/kushview/Element.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="alsa jack pulseaudio test"
RESTRICT="!test? ( test )"

# Runtime Dependencies (Libraries linked at runtime)
RDEPEND="
	dev-libs/boost
	media-fonts/roboto
	media-libs/freetype
	media-libs/ladspa-sdk
	net-misc/curl
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXext
	x11-libs/libXinerama
	x11-libs/libXrandr
	x11-libs/libXrender
	alsa? ( media-libs/alsa-lib )
	jack? ( virtual/jack )
	pulseaudio? ( media-libs/libpulse )
"

DEPEND="${RDEPEND}
	dev-cpp/sol2
	media-libs/juce
"

BDEPEND="
	llvm-core/clang
	virtual/pkgconfig
"

src_configure() {
	tc-export CC CXX
	export CC=clang
	export CXX=clang++

	# --- SANDBOX FIX ---
	# The build runs 'juce_lv2_helper' which tries to scan for MIDI devices.
	# We allow it to 'predict' access to /dev/snd/seq so the sandbox doesn't kill the build.
	# It will still fail to open the device (Permission Denied), but the build will continue.
	addpredict /dev/snd/seq
	addpredict /dev/snd/timer

	local mycmakeargs=(
		-DELEMENT_BUILD_PLUGINS=ON
		-DCMAKE_BUILD_TYPE=Release
		-DFETCHCONTENT_TRY_FIND_PACKAGE_MODE=ALWAYS
		-DFETCHCONTENT_FULLY_DISCONNECTED=ON
	)

	cmake_src_configure
}

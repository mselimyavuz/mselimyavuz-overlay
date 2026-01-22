# mselimyavuz-overlay

A personal Gentoo overlay, featuring modern, Pro-Audio applications and libraries not currently available (or outdated) in the main Gentoo or proaudio-gentoo repository.

## Packages Included

| Category | Package | Description |
| :--- | :--- | :--- |
| **media-sound** | `element` | Advanced Audio Plugin Host (VST/AU/LV2) by Kushview. |
| **media-sound** | `carla` | Audio plugin host with support for many audio drivers and plugin formats. |
| **media-libs** | `juce` | Open-source cross-platform C++ application framework (Live -9999). |

*Note: All packages are live ebuilds (`-9999`), meaning they build directly from the latest source code on GitHub.*

## Installation

You can add this overlay to your system using `eselect-repository`.

### 1. Add the Repository
```bash
sudo eselect repository add mselimyavuz-overlay git [https://gitlab.com/mselimyavuz/mselimyavuz-overlay.git](https://gitlab.com/mselimyavuz/mselimyavuz-overlay.git)
sudo emaint sync -r mselimyavuz-overlay

### 2. Unmasking Packages
Since these are live (`-9999`) ebuilds, you must accept the `**` keyword for them.

**For a specific package:**
```bash
echo "=media-sound/element-9999 **" | sudo tee -a /etc/portage/package.accept_keywords/mselimyavuz-overlay
```

**Or for the entire overlay:**
```bash
echo "*/*::mselimyavuz-overlay **" | sudo tee -a /etc/portage/package.accept_keywords/mselimyavuz-overlay
```

## Usage Notes

### JUCE Examples Warning
The `media-libs/juce` package has an `examples` USE flag. **It is recommended to keep this disabled.**
* Building the examples requires massive RAM (32GB+ recommended for parallel builds).
* The `WebViewPluginDemo` is known to fail in headless build environments (like Portage sandbox) due to Sandbox violations when trying to open a display.

To install JUCE safely:
```bash
echo "media-libs/juce -examples" | sudo tee -a /etc/portage/package.use/juce
sudo emerge -av media-libs/juce
```

### Installing Element
Once the overlay is added, simply run:
```bash
sudo emerge -av media-sound/element::mselimyavuz-overlay
```

## License
All ebuilds in this repository are distributed under the **GPL-2** license, consistent with the Gentoo Linux main repository.

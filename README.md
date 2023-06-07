<a name="readme-top"></a>

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![LinkedIn][linkedin-shield]][linkedin-url]



<!-- PROJECT LOGO -->
<br />
<div align="center">
  <!-- <a href="https://github.com/nub31/awesome">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a> -->

<h3 align="center">awesome dotfiles</h3>

  <p align="center">
    My basic awesomewm configuration and installation script. Config is based on arch, and uses the awesome-git package.
    <br />
    <br />
    <a href="https://github.com/nub31/awesome/issues">Report Bug</a>
    ·
    <a href="https://github.com/nub31/awesome/issues">Request Feature</a>
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

<!-- [![Product Name Screen Shot][product-screenshot]](https://example.com) -->
This a very basic awesomewm configuration for arch. 

I dont really care about rice, so this config is just the stock awesomewm config with custom keybinds, default applications and custom startup applications.

The repo also contains the config files for some og the dependencies of the awesome config such as kitty, picom, rofi etc.

I also included a installation script that lets the user choose between a minimal, default and full configuration. The minimal configuration only contains the packages required for awesome to launch, such as xorg and awesome-git. The default configuration also contains the packages i refrence in the awesome config. This includes packages such as startup application (picom, feh) and applications connected to a keybind (vscode, nemo, kitty, firefox)

The installation script also prompts the user if he wants to use some custom cursors included in the project, and if the user wants to disable mouse acceleration.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- GETTING STARTED -->
## Getting Started

### Prerequisites

You need to have an arch shell running. You can reach this point easily by booting to an arch ISO, and running through the archinstall wizard.

Make sure you select Network-Manager and pulseaudio for your network and audio engine. 

For the Profile, either select Desktop - Xorg, or minimal. If you choose Xorg, archinstall will handle the driver installation

### Installation

1. Clone the repo
   ```sh
   git clone https://github.com/nub31/awesome.git
   ```
2. cd into the repository
   ```sh
   cd awesome 
   ```

3. Start the installation script (As a normal user. Dont use root) and follow the prompts
   ```sh
   sh setup.sh
   ```

3. Edit the awesome configuration to your liking
   ```sh
   code ~/.config/awesome/rc.lua
   ```


<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- CONTACT -->
## Contact

Your Name - [@nub1357](https://twitter.com/nub1357) - oliverlhs@outlook.com

Project Link: [https://github.com/nub31/awesome](https://github.com/nub31/awesome)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

* [Bibata Ice Cursors](https://github.com/ful1e5/Bibata_Cursor)
* [Firewatch Wallpaper](https://wallpaperaccess.com/4k-firewatch)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/nub31/awesome.svg?style=for-the-badge
[contributors-url]: https://github.com/nub31/awesome/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/nub31/awesome.svg?style=for-the-badge
[forks-url]: https://github.com/nub31/awesome/network/members
[stars-shield]: https://img.shields.io/github/stars/nub31/awesome.svg?style=for-the-badge
[stars-url]: https://github.com/nub31/awesome/stargazers
[issues-shield]: https://img.shields.io/github/issues/nub31/awesome.svg?style=for-the-badge
[issues-url]: https://github.com/nub31/awesome/issues
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/oliver-stene-744a96200
[product-screenshot]: images/screenshot.png

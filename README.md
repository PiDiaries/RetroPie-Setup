RetroPie-Setup
==============
This is my fork of RetroPie.  I'll be adding some stuff that I usually install automatically when doing a fresh install of Linux. As I always install RetroPie on new builds I might as well add everything else and automate more of the process. 
Things that are usually installed from the Distro's repositories like fonts, nfs, gnome-tweaks may go in the system depends and installed when first running retropie_setup.sh


Move some stuff so using Rom Managers is made easier.  So ONLY roms in roms folders. Likely $romdir/roms for mame amd FBA which means all the other mame extras can go in the Rom folder too without messing up Rom Managers that don't like extra stuff in the rom folder.

Remove configs from /opt/retropie/configs that are symlinked to the home folder.  Keep them in the home folder to make it easier for multi users to have their own settings. I'll eventually move everything.  Makes it easier for multiusers and you don't lose stuff if you keep your home folder intact during an OS reinstall if it wipes the /opt folder. 

Change the core options to the $system/retroarch.cfg.  So that when you have megadrive and genesis using the same core you can have different core options for each.  i.e. genesis on the ntsc options and megadrive on pal. 

Give each mame core it's own rom folder and system so you can keep multiple romsets with their own settings easier if you so wish.  

Automate the bezel project
 

Other things that are built from source I'll probably put into a install script. 

I had most of this done before but lack of knowledge meant it got messy and wasn't as clean as it could have been.  So I am doing it again. 

I am a total novice Use at your own risk.  Some stuff you may or may not find useful.

General Usage
-------------

Shell script to setup the Raspberry Pi, Vero4K, ODroid-C1 or a PC running Ubuntu with many emulators and games, using EmulationStation as the graphical front end. Bootable pre-made images for the Raspberry Pi are available for those that want a ready-to-go system, downloadable from the releases section of GitHub or via our website at https://retropie.org.uk.

This script is designed for use on Raspberry Pi OS (previously called Raspbian) on the Raspberry Pi, OSMC on the Vero4K or Ubuntu on the ODroid-C1 or a PC.

To run the RetroPie Setup Script make sure that your APT repositories are up-to-date and that Git is installed:

```shell
sudo apt-get update
sudo apt-get dist-upgrade
sudo apt-get install git
```

Then you can download the latest RetroPie setup script with:

```shell
cd
git clone --depth=1 https://github.com/RetroPie/RetroPie-Setup.git
```

The script is executed with:

```shell
cd RetroPie-Setup
sudo ./retropie_setup.sh
```

When you first run the script it may install some additional packages that are needed.

Binaries and Sources
--------------------

On the Raspberry Pi, RetroPie Setup offers the possibility to install from binaries or source. For other supported platforms only a source install is available. Installing from binary is recommended on a Raspberry Pi as building everything from source can take a long time.

For more information, visit the site at https://retropie.org.uk or the repository at https://github.com/RetroPie/RetroPie-Setup.

Docs
----

You can find useful information about several components and answers to frequently asked questions in the [RetroPie Docs](https://retropie.org.uk/docs/). If you think that there is something missing, you are invited to submit a pull request to the [RetroPie-Docs repository](https://github.com/RetroPie/RetroPie-Docs).


Thanks
------

This script just simplifies the usage of the great works of many other people that enjoy the spirit of retrogaming. Many thanks go to them!


Things done in this fork
added system and rom folder for mame2003-plus
removed genesis symlink
removed kodi and Retroarch config folders symlinks. Now point to standard home folder configs. 
# Synfig Portable Maker
This script permits to create easily a PortableApps package of SynfigStudio
It works only for Synfig x64 (1.2.2, 1.3.11-pre5 and 1.3.10-seterrormode currently)
You can package directly from your own Windows or from a [Windows 10 development environment](https://developer.microsoft.com/en-us/windows/downloads/virtual-machines)

## Required Apps and Files

### PortableApps
|Tool|Link|
|---|---|
| Platform (optional) | https://portableapps.com/download |
| Compactor \* | https://portableapps.com/apps/utilities/portableapps.com_appcompactor |
| Launcher  \* | https://portableapps.com/apps/development/portableapps.com_launcher |
| Installer \* | https://portableapps.com/apps/development/portableapps.com_installer |
| 7-Zip     \* | https://portableapps.com/apps/utilities/7-zip_portable |

\* Can be installed directly from the PortableApps Platform 
### Synfig x64

|Version|Link|
|-------|----|
|**1.2.2**|https://downloads.synfig.org/stable/SynfigStudio-1.2.2-18.09.14-win64-286f1.zip|
|**1.3.11-pre5**|https://downloads.synfig.org/almost-1.3.11/SynfigStudio-1.3.11-pre5-64bit-2365f.zip|
|**1.3.10-seterrormode**|https://downloads.synfig.org/almost-1.3.11/SynfigStudio-1.3.10-testing-19.02.07-win64-47da2-seterrormode.zip|

## Steps

> **Note**
> Before anything, if you want to keep your current settings with your installed Synfig,
> do a backup of your C:\Users\YOUR_USERNAME\Synfig folder.
> We can "reinject" it later in the portable version.
### Install required Apps and Files
- Install first the PortableApps Platform (for convenience)
- Then Compactor, Launcher, Installer and 7-Zip (can be done from Platform directly)
- Clone this repository in C:\SynfigPortable_Maker for example or any any where you have write access  (refered as "basedir" after)
- Download Synfig x64 in the versions you want and place them in the basedir

### Configuration
Edit _MakePortable.bat_ and change the parameters according your needs
|Parameter|Role|
|-|-|
|SYNFIG_VERSION|1.2.2, 1.3.11-pre5 or 1.3.10-seterrormode|
|PA_BASE|depends where your PortableApps platform has been installed|
|USE_COMPACTOR|optional (more time to build, less disk space once installed)|
|MAKE_INSTALLER|optional (_Build contains an uncompressed portable version after execution of the script)|
|SHOW_CONSOLE|optional - how console at runtime|

### Execution of the script
Open a console as Admin (Win+X)
_If you have a PowerShell prompt, enter cmd_
Then _cd your_basedir_
_MakePortable.bat_

> **Note**
> Almost everything is done automatically
> You may have to confirm some options according your settings:
> If you use Compactor, keep NRV2E and validate (also at the end)
> You can still cancel its execution at prompt without any issue

### Result
The installer will be produced in your _basedir_
_Build contains a flat portable version at the end of the process

Install or copy your portable version of Synfig

_You can also reinject your settings placing them in the __/Data/Synfig__ folder under your Synfig Portable version_

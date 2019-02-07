@echo off

:: ===========================================================================
:: ----- Modify according your needs -----

:: 1.2.2, 1.3.11-pre5, 1.3.10-seterrormode (case sensistive)
set SYNFIG_VERSION=1.2.2

:: ! No "", no space,  no \ at the end !
set PA_BASE=c:\PortableApps\PortableApps

:: Use Compactor, spares space but takes longer (Y or N only)
set USE_COMPACTOR=Y

:: Make the installer (Y or N only)
:: You could copy the result of _Build directly in any folder and have a working instance!
set MAKE_INSTALLER=Y

:: Show console at runtime (Y or N only)
set SHOW_CONSOLE=Y

:: ----- Do not Modify below -----
:: ===========================================================================

:: !!! Do not Modify below ( unless you dare :P ) !!!
IF "%SYNFIG_VERSION%"=="1.2.2" (
  set ZIPFILE=SynfigStudio-1.2.2-18.09.14-win64-286f1.zip
)
IF "%SYNFIG_VERSION%"=="1.3.11-pre5" (
  set ZIPFILE=SynfigStudio-1.3.11-pre5-64bit-2365f.zip
)
IF "%SYNFIG_VERSION%"=="1.3.10-seterrormode" (
  set ZIPFILE=SynfigStudio-1.3.10-testing-19.02.07-win64-47da2-seterrormode.zip
)

set PA_7ZIP=%PA_BASE%\7-ZipPortable\App\7-Zip64\7z.exe
set PA_COMPACTOR=%PA_BASE%\PortableApps.comAppCompactor\PortableApps.comAppCompactor.exe
set PA_LAUNCHER_GENERATOR=%PA_BASE%\PortableApps.comLauncher\PortableApps.comLauncherGenerator.exe
set PA_INSTALLER=%PA_BASE%\PortableApps.comInstaller\PortableApps.comInstaller.exe
set BASE_SYNFIG_PORTABLE=%~dp0

cd %BASE_SYNFIG_PORTABLE%


:clean
echo Clean...
rmdir /S /Q .\_Build\
mkdir _Build


:structure
echo Copying Structure...
xcopy .\_Structure\*.* %BASE_SYNFIG_PORTABLE%\_Build /E 2>NUL


:extract
echo Extracting...
%PA_7ZIP% x -o%BASE_SYNFIG_PORTABLE%\_Build\App\Synfig64\ %ZIPFILE% 2>NUL


:patching
echo Patching for the GUI font...
  copy /Y %BASE_SYNFIG_PORTABLE%_Config\settings.ini	  %BASE_SYNFIG_PORTABLE%_Build\App\Synfig64\share\gtk-3.0\ 2>NUL

echo Selecting the correct version of appinfo.ini...
  copy /Y %BASE_SYNFIG_PORTABLE%_Config\%SYNFIG_VERSION%.ini %BASE_SYNFIG_PORTABLE%_Build\App\AppInfo\AppInfo.ini 2>NUL

IF "%SHOW_CONSOLE%" == "Y" goto with_console
  echo Patching synfigstudio.bat (with GTK_CSD=0 and NO CONSOLE)
    copy /Y %BASE_SYNFIG_PORTABLE%_Config\synfigstudio.bat %BASE_SYNFIG_PORTABLE%_Build\App\Synfig64\synfigstudio.bat 2>NUL
    goto patching_end
:with_console
  echo Patching synfigstudio.bat (with GTK_CSD=0 and SHOW CONSOLE)
    copy /Y %BASE_SYNFIG_PORTABLE%_Config\synfigstudioconsole.bat %BASE_SYNFIG_PORTABLE%_Build\App\Synfig64\synfigstudio.bat 2>NUL
    goto patching_end
:patching_end


:cleansynfig
echo Cleaning Synfig...

pushd
cd    .\_Build\
del   /S /Q .gitignore                                2>NUL
popd

pushd
cd    .\_Build\App\Synfig64\

del   /F /Q .\version-*                               2>NUL
del   /F /Q .\lib\*.la                                2>NUL

del   /F /Q .\lib\*.def                               2>NUL
del   /F /Q .\lib\*.sh                                2>NUL
del   /F /Q .\lib\*.alias                             2>NUL

rmdir /S /Q .\lib\atkmm-1.6                           2>NUL
rmdir /S /Q .\lib\cairomm-1.0                         2>NUL
rmdir /S /Q .\lib\cmake                               2>NUL
rmdir /S /Q .\lib\gdkmm-3.0                           2>NUL
del   /F /Q .\lib\gdk-pixbuf-2.0\2.10.0\loaders\*.la* 2>NUL
rmdir /S /Q .\lib\gio                                 2>NUL
rmdir /S /Q .\lib\giomm-2.4                           2>NUL
rmdir /S /Q .\lib\glib-2.0                            2>NUL
rmdir /S /Q .\lib\glibmm-2.4                          2>NUL
del   /F /Q .\lib\gtk-3.0\3.0.0\immodules\*.la*       2>NUL
rmdir /S /Q .\lib\gtkmm-3.0                           2>NUL
rmdir /S /Q .\lib\ImageMagick-6.8.7                   2>NUL
rmdir /S /Q .\lib\libffi-3.2.1                        2>NUL
rmdir /S /Q .\lib\libxml++-2.6                        2>NUL
rmdir /S /Q .\lib\pangomm-1.4                         2>NUL
rmdir /S /Q .\lib\pkgconfig                           2>NUL
rmdir /S /Q .\lib\sigc++-2.0                          2>NUL
del   /F /Q .\lib\synfig\modules\*.la                 2>NUL
popd


:compactor
IF "%USE_COMPACTOR%" == "N" goto compactor_end
  echo Using Compactor (Time Consuming)
  echo !!! YOU CAN STILL PUSH CANCEL TO SKIP !!!
  echo !!! Keep NRV2E, validate, and validate at the end too !!!
  %PA_COMPACTOR% %BASE_SYNFIG_PORTABLE%_Build
)
:compactor_end


:launchergenerator
echo Launcher Generator...
  %PA_LAUNCHER_GENERATOR% %BASE_SYNFIG_PORTABLE%_Build


:installer
IF "%MAKE_INSTALLER%" == "N" goto installer_end
  echo Making Installer for Synfig %SYNFIG_VERSION%...
  %PA_INSTALLER%  %BASE_SYNFIG_PORTABLE%_Build 2>NUL
:installer_end

goto end


:error
echo ERROR - Somewhere in the settings


:end
cd %BASE_SYNFIG_PORTABLE%
echo Done!
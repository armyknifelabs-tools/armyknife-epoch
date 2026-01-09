set dotenv-load
just := just_executable()
make := `which make`

build:
    mkdir -p build
    {{ just }} armyknife-applets/build-release
    {{ just }} armyknife-applibrary/build-release
    {{ just }} armyknife-bg/build-release
    {{ make }} -C armyknife-comp all
    {{ just }} armyknife-edit/build-release
    {{ just }} armyknife-files/build-release
    {{ just }} armyknife-greeter/build-release
    {{ just }} armyknife-idle/build-release
    {{ just }} armyknife-initial-setup/build-release
    {{ just }} armyknife-launcher/build-release
    {{ just }} armyknife-notifications/build-release
    {{ just }} armyknife-osd/build-release
    {{ just }} armyknife-panel/build-release
    {{ just }} armyknife-player/build-release
    {{ just }} armyknife-randr/build-release
    {{ just }} armyknife-screenshot/build-release
    {{ just }} armyknife-settings/build-release
    {{ make }} -C armyknife-settings-daemon all
    {{ just }} armyknife-session/all
    {{ just }} armyknife-store/build-release
    {{ just }} armyknife-term/build-release
    {{ make }} -C armyknife-wallpapers all
    {{ make }} -C armyknife-workspaces all
    {{ just }} armyknife-launcher-backend/build-release
    {{ make }} -C xdg-desktop-portal-armyknife all

install rootdir="" prefix="/usr/local": build
    {{ just }} rootdir={{rootdir}} prefix={{prefix}} armyknife-applets/install
    {{ just }} rootdir={{rootdir}} prefix={{prefix}} armyknife-applibrary/install
    {{ just }} rootdir={{rootdir}} prefix={{prefix}} armyknife-bg/install
    {{ make }} -C armyknife-comp install DESTDIR={{rootdir}} prefix={{prefix}}
    {{ just }} rootdir={{rootdir}} prefix={{prefix}} armyknife-edit/install
    {{ just }} rootdir={{rootdir}} prefix={{prefix}} armyknife-files/install
    {{ just }} rootdir={{rootdir}} prefix={{prefix}} armyknife-greeter/install
    {{ just }} rootdir={{rootdir}} prefix={{prefix}} armyknife-icons/install
    {{ just }} rootdir={{rootdir}} prefix={{prefix}} armyknife-idle/install
    {{ just }} rootdir={{rootdir}} prefix={{prefix}} armyknife-initial-setup/install
    {{ just }} rootdir={{rootdir}} prefix={{prefix}} armyknife-launcher/install
    {{ just }} rootdir={{rootdir}} prefix={{prefix}} armyknife-notifications/install
    {{ just }} rootdir={{rootdir}} prefix={{prefix}} armyknife-osd/install
    {{ just }} rootdir={{rootdir}} prefix={{prefix}} armyknife-panel/install
    {{ just }} rootdir={{rootdir}} prefix={{prefix}} armyknife-player/install
    {{ just }} rootdir={{rootdir}} prefix={{prefix}} armyknife-randr/install
    {{ just }} rootdir={{rootdir}} prefix={{prefix}} armyknife-screenshot/install
    {{ just }} rootdir={{rootdir}} prefix={{prefix}} armyknife-settings/install
    {{ make }} -C armyknife-settings-daemon install DESTDIR={{rootdir}} prefix={{prefix}}
    {{ just }} rootdir={{rootdir}} prefix={{prefix}} armyknife-session/install
    {{ just }} rootdir={{rootdir}} prefix={{prefix}} armyknife-store/install
    {{ just }} rootdir={{rootdir}} prefix={{prefix}} armyknife-term/install
    {{ make }} -C armyknife-wallpapers install DESTDIR={{rootdir}} prefix={{prefix}}
    {{ make }} -C armyknife-workspaces install DESTDIR={{rootdir}} prefix={{prefix}}
    {{ just }} rootdir={{rootdir}} armyknife-launcher-backend/install
    {{ make }} -C xdg-desktop-portal-armyknife install DESTDIR={{rootdir}} prefix={{prefix}}

_mkdir dir:
   mkdir -p dir

sysext dir=(invocation_directory() / "armyknife-sysext") version=("nightly-" + `git rev-parse --short HEAD`): (_mkdir dir) (install dir "/usr")
    #!/usr/bin/env sh
    mkdir -p {{dir}}/usr/lib/extension-release.d/
    cat >{{dir}}/usr/lib/extension-release.d/extension-release.armyknife-sysext <<EOF
    NAME="Armyknife Desktop"
    VERSION={{version}}
    $(cat /etc/os-release | grep '^ID=')
    $(cat /etc/os-release | grep '^VERSION_ID=')
    EOF
    echo "Done"

clean:
    rm -rf armyknife-sysext
    rm -rf armyknife-applets/target
    rm -rf armyknife-applibrary/target
    rm -rf armyknife-bg/target
    rm -rf armyknife-comp/target
    rm -rf armyknife-edit/target
    {{ just }} armyknife-files/clean
    rm -rf armyknife-greeter/target
    {{ just }} armyknife-idle/clean
    {{ just }} armyknife-initial-setup/clean
    rm -rf armyknife-launcher/target
    rm -rf armyknife-panel/target
    rm -rf armyknife-player/target
    rm -rf armyknife-notifications/target
    rm -rf armyknife-osd/target
    rm -rf armyknife-randr/target
    rm -rf armyknife-screenshot/target
    rm -rf armyknife-settings/target
    rm -rf armyknife-settings-daemon/target
    rm -rf armyknife-session/target
    {{ just }} armyknife-store/clean
    {{ just }} armyknife-term/clean
    {{ make }} -C armyknife-wallpapers clean
    rm -rf armyknife-workspaces/target
    {{ just }} armyknife-launcher-backend/clean
    rm -rf xdg-desktop-portal-armyknife/target

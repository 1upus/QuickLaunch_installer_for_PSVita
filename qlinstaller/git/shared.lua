-- Constants

APP_REPO = "1upus"
APP_PROJECT = "QuickLaunch_installer_for_PSVita"

APP_VERSION_MAJOR = 0x00 -- major.minor
APP_VERSION_MINOR = 0x51

APP_VERSION = ((APP_VERSION_MAJOR << 0x18) | (APP_VERSION_MINOR << 0x10)) -- Union Binary

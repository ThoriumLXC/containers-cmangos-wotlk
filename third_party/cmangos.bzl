"""
Dependency installation for the cmangos repositories.
"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

CMANGOS_MANGOS_WOTLK_COMMIT = "685b5983e5edc6070fc51c8dca9eb8c67dee9e8b"
CMANGOS_PLAYERBOTS_COMMIT = "50a69d2071c723e4f49306ab1ccfb434fccb0661"

SOURCE_REF_LABELS = {
    # cmangos.net/mangos-wotlk
    "net.cmangos.mangos-wotlk.revision": CMANGOS_MANGOS_WOTLK_COMMIT,
    "net.cmangos.mangos-wotlk.source": "https://github.com/cmangos/mangos-wotlk",
    "net.cmangos.mangos-wotlk.url": "https://github.com/cmangos/mangos-wotlk",
    # cmangos.net/playerbots
    "net.cmangos.playerbots.revision": CMANGOS_PLAYERBOTS_COMMIT,
    "net.cmangos.playerbots.source": "https://github.com/cmangos/playerbots",
    "net.cmangos.playerbots.url": "https://github.com/cmangos/playerbots",
    # cmangos.net/wotlk-db
    "net.cmangos.wotlk-db.revision": "2025-02-22",
    "net.cmangos.wotlk-db.source": "https://github.com/cmangos/wotlk-db",
    "net.cmangos.wotlk-db.url": "https://github.com/cmangos/wotlk-db",
}

def import_dependencies(name = "cmangos"):
    """Setup the archives to pull the git repositories for cmangos-wotlk

    Args:
        name: A name prefix for all repositories.
    """

    http_archive(
        name = "{name}_mangos_wotlk".format(name = name),
        url = "https://github.com/cmangos/mangos-wotlk/archive/{commit}.tar.gz".format(commit = CMANGOS_MANGOS_WOTLK_COMMIT),
        strip_prefix = "mangos-wotlk-{commit}".format(commit = CMANGOS_MANGOS_WOTLK_COMMIT),
        sha256 = "d2b990fda9effb248257b5898236d052da0b5b0aebec224e0039c4e74376a410",
        build_file = "//:third_party/cmangos_mangos_wotlk.BUILD",
        patches = [
            "//:third_party/patches/cmangos/mangos-wotlk/CMakeLists.patch",
        ],
    )

    http_archive(
        name = "{name}_wotlk_db".format(name = name),
        url = "https://github.com/ThoriumLXC/vmangos-database/releases/download/WOTLKDB/wotlk-all-db.zip",
        sha256 = "ace98fd7665a398d63414f69b958e7a2f62a243a5008e8455ae4604b05029361",
        build_file = "//:third_party/cmangos_wotlk_db.BUILD",
    )

    http_archive(
        name = "{name}_wotlk_playerbots".format(name = name),
        url = "https://github.com/cmangos/playerbots/archive/{commit}.tar.gz".format(commit = CMANGOS_PLAYERBOTS_COMMIT),
        strip_prefix = "playerbots-{commit}".format(commit = CMANGOS_PLAYERBOTS_COMMIT),
        sha256 = "42d1a37dd1043f9f2d26d046d7f57c3d8f8768df781b62261e778f12092741cf",
        build_file = "//:third_party/cmangos_wotlk_playerbots.BUILD",
    )

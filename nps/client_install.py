import argparse
import shutil
import subprocess
from pathlib import Path


def get_args():
    parser = argparse.ArgumentParser(description="Install nps client")
    parser.add_argument("-s", "--server", help="nps server address", required=True)
    parser.add_argument("-p", "--port", help="nps server port", default=8024)
    parser.add_argument("-v", "--vkey", help="nps client vkey", required=True)
    return parser.parse_args()


def is_tool(name):
    """Check whether `name` is on PATH and marked as executable."""
    return shutil.which(name) is not None


def _colorcode(code: int) -> str:
    return "\033[" + str(code) + "m"


_RED = _colorcode(31)
_GREEN = _colorcode(32)
_YELLOW = _colorcode(33)
_BOLD = _colorcode(1)
_RESET = _colorcode(0)


def print_green(string: str, bold=False) -> None:
    print(f"{_BOLD if bold else ''}{_GREEN}{string}{_RESET}")


def print_yellow(string: str, bold=False) -> None:
    print(f"{_BOLD if bold else ''}{_YELLOW}{string}{_RESET}")


def print_red(string: str, bold=False) -> None:
    print(f"{_BOLD if bold else ''}{_RED}{string}{_RESET}")


def main():
    args = get_args()
    server = str(args.server).strip() + ":" + str(args.port)
    vkey = args.vkey
    print("NPS Server : ", end="")
    print_green(server, bold=True)
    print("Client Vkey: ", end="")
    print_green(vkey, bold=True)
    # ask for confirmation
    print_yellow("Are you sure? (y/n)")
    answer = input()
    if answer != "y":
        print_red("Aborting...")
        return

    HOME = Path.home()
    NPS_DIR = HOME / ".nps_client"
    DOWNLOAD_PATH: Path = NPS_DIR / "linux_amd64_client.tar.gz"
    NPC_PATH: Path = NPS_DIR / "npc"

    if is_tool("npc"):
        print_green("npc command is already installed")
        return

    ### DOWNLOAD NPS CLIENT ###

    if NPS_DIR.is_dir() and DOWNLOAD_PATH.is_file():
        print_green("nps client is already downloaded")
    else:
        print_green(f"Creating directory {NPS_DIR}")
        NPS_DIR.mkdir(parents=True, exist_ok=True)
        print_green(f"Downloading nps client to {DOWNLOAD_PATH}")
        cmd = f"wget https://github.com/ehang-io/nps/releases/download/v0.26.10/linux_amd64_client.tar.gz -O {DOWNLOAD_PATH}"
        proc = subprocess.run(cmd, shell=True, stdout=subprocess.DEVNULL)
        if proc.returncode != 0:
            print_red("Download failed")
            return
        if DOWNLOAD_PATH.is_file():
            print_green("Download successful")

    ### UNPACK NPS CLIENT ###

    if NPC_PATH.is_file():
        print_green("nps client is already unpacked")
    else:
        print_green(f"Unpacking nps client {DOWNLOAD_PATH}")
        cmd = f"tar -xvf {DOWNLOAD_PATH} -C {NPS_DIR}"
        proc = subprocess.run(cmd, shell=True, stdout=subprocess.DEVNULL)
        if proc.returncode != 0:
            print_red("Unpack failed")
            return
        if NPC_PATH.is_file():
            print_green("Unpack successful")

    ### UNINSTALL OLD NPC Profile ###
    print_green("Uninstalling old npc profile...")
    cmd = f"{NPC_PATH} uninstall"
    proc = subprocess.run(cmd, shell=True, stdout=subprocess.DEVNULL)
    if proc.returncode != 0:
        print_red("Uninstall old npc profile failed")

    ### INSTALL NEW NPC Profile ###
    print_green("Installing new npc profile...")
    cmd = f"sudo {NPC_PATH} install -server={server} -vkey={vkey}"
    proc = subprocess.run(cmd, shell=True, stdout=subprocess.DEVNULL)
    if proc.returncode != 0:
        print_red("Install new npc profile failed")
        return
    print_green("Install successful")

    ### START NPS CLIENT ###
    print_green("Starting nps client...")
    cmd = f"sudo {NPC_PATH} start"
    proc = subprocess.run(cmd, shell=True, stdout=subprocess.DEVNULL)
    if proc.returncode != 0:
        print_red("Start nps client failed")
    print_green("Start successful")


if __name__ == "__main__":
    main()

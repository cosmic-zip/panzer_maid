![panzer](wiki/files/index.png)

# PanzerMaid

# Nothing to see here anymore.

PanzerMaid is your extremely useful and versatile cybersecurity companion library for Linux, macOS, and Android. The new and improved version includes all past projects like MaidZ, Witch_Craft, and LET.

### What does it do

PanzerMaid is a CLI automation engine with infinite support for extensions through db.json (cybersecurity scripts), using the uwu parser and Dart code.


### How it works

![panzerMaidLib](wiki/files/panzerMaidLib.png)

### Features

- **Task Automation**: Automate routine tasks to improve efficiency and consistency.
- **Forensic Research**: Tools and utilities for conducting in-depth forensic investigations.
- **OSINT (Open Source Intelligence)**: Gather and analyze publicly available information for cybersecurity purposes.
- **Scanning**: Perform detailed scans of systems, networks, and applications to identify vulnerabilities.
- **Backup and Copying**: Securely backup and copy critical data.
- **Intrusion Testing**: Test the security of applications and APIs to identify and mitigate vulnerabilities.
- **Rootkit Prevention**: Detect and prevent rootkit infections to ensure system integrity.

### Does it only execute shell scripts?

No. PanzerMaid is the CLI interface using tinybox. The tinybox is a simple Linux shell and includes dos_utils.dart with functions like ls, tree, mkdir, and can emulate devices like /dev/random and /dev/zero.

In later versions, the dos_utils will expand to become more like a busybox, suitable for use on both Unix-like systems and Android, utilizing a Flutter app to spawn the initial thread and execute external binaries like nmap or ffmpeg.

### What does the @w@ (UwU) parser do?

It's a simple parser for shell scripts compatible with sh. You need to replace the values in the shell script with @@value. Its use case is more limited if you use hand-made shell scripts or programming languages like Ruby or Python. It's indeed a stronger replacement for **alias**.

```bash
    foo -v -t --some-thing --another @@value -fancy=@@fancy-value -s
```

When calling it:

```bash
    myfoo --fancy-value SomeValue --value 1984
```

#### Can it be used for:

1. Scheduling tasks as a daemon.
2. Parsing and executing complex shell scripts with a large number of parameters.
3. Managing Linux systems.
4. Functioning as a shell and running statically linked binaries in any viable environment.
5. Serving as a unit app for proot on Android (not available now).

In the future, it will not require any external tools or advanced permissions because it uses 100% self-contained execs (scripts or binaries) to perform all tasks.

## Integrated app

![grid_app](wiki/files/bean.png)

| Project                        | Description                                                                                                                                               |
| ------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **MaidZ**                      | Improved an deferent version of witch_craft and previous tools, uses bank.json to store all alias, commands, and single line shell scripts                |
| **Witch_Craft**                | Rust based framework, store all alias inside structs                                                                                                      |
| **LinuxEvilToolkit**           | Original toolkit from 2018, uses ruby and store all alias and scripts inside variables, the most complete version, deprecated due complexity              |
| **MaidSecLists 2024 Rev2**     | My own version of SecLists but using standard file names, merging word lists and remove garbage files, this rev2 refers to MaidZ version of MaidSecLists. |
| **The book Hacker Heuristics** | My collection of notes, scripts and articles, news, etc.                                                                                                  |

## UNIX AND MSDOS MODES

Almost done!

## Project origins

Long story short: In 2019, I had to install Arch Linux on my laptop with LUKS. I decided to write a shell script to automate most of the installation, packages, configurations, etc. The script grew big, and I began to improve it. I ported it to Python, later to C (although I failed, I learned a bit of C), then to Ruby (failed again, but learned Ruby and something about Rails), and later to Rust. Rust was amazing, but I needed to work with Python. Keeping such a giant stack of technologies and programming languages was killing my performance in all of them.

Now, I have migrated my entire stack to Flutter and backend to serverless technologies like Lambda, Firebase, etc. The fact that Dart compiles also helps, as I can just build and install a small binary. I plan to implement everything in Dart and stop using third-party tools like dirb, nmap, whois, etc. This will allow me to create an extremely useful and rootless hacking app for iOS and Android.

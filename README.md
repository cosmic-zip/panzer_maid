![panzer](docs/index.png)

![shot](docs/shot.png)

# PanzerMaid

The new and improved version of MaidZ, Witch_Craft and LET include all past projects, but this time using in dart lang.

Panzer_Maid is your extremely useful and versatile cybersecurity companion app for Linux, Windows, macOS, iOS, and Android. It does not require any external tools or advanced permissions because it uses 100% native code to perform all tasks.

> Panzer_Maid is not an alias for other tools but has a curated version of the Maidz database with useful Linux automations.

## UNIX AND MSDOX MODES

**Rewrite every thing again, but why?**

Long story short: In 2019, I had to install Arch Linux on my laptop with LUKS. I decided to write a shell script to automate most of the installation, packages, configurations, etc. The script grew big, and I began to improve it. I ported it to Python, later to C (although I failed, I learned a bit of C), then to Ruby (failed again, but learned Ruby and something about Rails), and later to Rust. Rust was amazing, but I needed to work with Python. Keeping such a giant stack of technologies and programming languages was killing my performance in all of them.

Now, I have migrated my entire stack to Flutter and backend to serverless technologies like Lambda, Firebase, etc. The fact that Dart compiles also helps, as I can just build and install a small binary. I plan to implement everything in Dart and stop using third-party tools like dirb, nmap, whois, etc. This will allow me to create an extremely useful and rootless hacking app for iOS and Android.

![grid_app](docs/bean.png)

| Project                    | Description                                                                                                                                               |
| ---------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **MaidZ**                  | Improved an deferent version of witch_craft and previous tools, uses bank.json to store all alias, commands, and single line shell scripts                |
| **Witch_Craft**            | Rust based framework, store all alias inside structs                                                                                                      |
| **LinuxEvilToolkit**       | Original toolkit from 2018, uses ruby and store all alias and scripts inside variables, the most complete version,   deprecated due complexity            |
| **MaidSecLists 2024 Rev2** | My own version of SecLists but using standard file names, merging word lists and remove garbage files, this rev2 refers to MaidZ version of MaidSecLists. |

<p align="center">
<p>BSD 3-Clause License</p>
<p>Copyright (c) 2024, Cosmic</p>
</p>

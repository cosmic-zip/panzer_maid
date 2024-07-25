# Ms dos commands
Based on the provided search results, here is a list of MS-DOS commands, categorized for easier reference:

## File Management

CD (Change Directory): Navigate through directories
DIR (Directory): List files and subdirectories
COPY: Copy files from one location to another
DEL (Delete): Delete files
REN (Rename): Rename files or directories
MKDIR: Create a new directory
RMDIR: Remove an existing directory
TREE: Graphically display the folder structure of a drive or path

## System Configuration

DATE: Show or set the current date
TIME: Show or set the current time
ATTRIB: Change file attributes (e.g., read-only, hidden)
MODE: Configure system devices (e.g., keyboard, display)
SCANDISK: Scan and fix disk errors
CHKDSK: Check and fix disk errors
FORMAT: Prepare a storage medium for data storage

## Utilities

DEBUG: Test and edit programs
EDIT: Start the MS-DOS editor for text file editing
EMM386: Enable or disable expanded-memory support
EXE2BIN: Convert executable files to binary format
HELP: Provide help information for MS-DOS commands

## Miscellaneous

APPEND: Set or display the search path for data files
ASSIGN: Redirect drive requests to a different drive
BACKUP: Backup files and directories
DEVICE: Load device drivers into memory
DEVICEHIGH: Load device drivers into upper memory
SHARE: Install file-sharing and locking capabilities
SYS: Transfer system files to a disk

## Notes

These commands are based on MS-DOS 6.22 and may vary slightly across different versions.
Refer to the detailed documentation or use the command followed by /? for detailed information on each command.
Understanding MS-DOS commands is still valuable for co


temp


PanzerMaid are much more than an shell script collection, It is an shell plus coreutils writen in native dart in a single binanry called: tinybox.

Tinybox include:
  shell with async await
  unixutils (ls, cd, mkdir) etc, similar to coreutils

knoing that we can start, unixutils contains an call(args) function, it routers
args to the function (ls, mkdir, cs, systeminfo, etc) and send the data.

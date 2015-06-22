![Logo](/lokiicon.jpg)
# Loki - Simple IOC Scanner

[![Join the chat at https://gitter.im/Neo23x0/Loki](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/Neo23x0/Loki?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Scanner for Simple Indicators of Compromise

Detection is based on four detection methods:

    1. File Name IOC
       Regex match on full file path/name

    2. Yara Rule Check
       Yara signature match on file data and process memory

    3. Hash check
       Compares known malicious hashes (MD5, SHA1, SHA256) with scanned files

The Windows binary is compiled with PyInstaller 2.1 and should run as x86 application on both x86 and x64 based systems.

## How-To Run LOKI and Analyse the Reports

### Run

  - Download the program archive via the button "Download ZIP" on the right sidebar
  - Unpack LOKI locally
  - Provide the folder to a target system that should be scanned: removable media, network share, folder on target system
  - Right-click on loki.exe and select "Run as Administrator" or open a command line "cmd.exe" as Administrator and run it from there (you can also run LOKI without administrative privileges but some checks will be disabled and relevant objects on disk will not be accessible)

### Reports

  - The resulting report will show a GREEN, YELLOW or RED result line.
  - Please analyse the findings yourself by:
    1. uploading non-confidential samples to Virustotal.com
    2. Search the web for the filename
    3. Search the web for keywords from the rule name (e.g. EQUATIONGroupMalware_1 > search for "Equation Group")
    4. Search the web for the MD5 hash of the sample
  - Please report back false positives via the "Issues" section, which is accessible via the right sidebar (mention the false positive indicator like a hash and/or filename and the rule name that triggered)

## Included IOCs

Loki currently includes the following IOCs:

  - Equation Group Malware (Hashes, Yara Rules [by Kaspersky](http://securelist.com/blog/research/68750/equation-the-death-star-of-malware-galaxy/) and [10 custom rules](http://pastebin.com/P0Fb9DPb) generated by us)
  - Carbanak APT - [Kaspersky Report](http://securelist.com/blog/research/68732/the-great-bank-robbery-the-carbanak-apt/) (Hashes, Filename IOCs - no service detection and Yara rules)
  - Arid Viper APT - [Trendmicro](http://blog.trendmicro.com/trendlabs-security-intelligence/arid-viper-gaza-vs-israel-cyber-conflict/) (Hashes)
  - Anthem APT Deep Panda Signatures (not officialy confirmed) (krebsonsecurity.com - see [Blog Post](http://krebsonsecurity.com/2015/02/china-to-blame-in-anthem-hack/))
  - Regin Malware (GCHQ / NSA / FiveEyes) (incl. Legspin and Hopscotch)
  - Five Eyes QUERTY Malware (Regin Keylogger Module - see: [Kaspesky Report](https://securelist.com/blog/research/68525/comparing-the-regin-module-50251-and-the-qwerty-keylogger/))
  - Skeleton Key Malware (other state-sponsored Malware) - Source: [Dell SecureWorks Counter Threat Unit(TM)](http://www.secureworks.com/cyber-threat-intelligence/threats/skeleton-key-malware-analysis/)
  - WoolenGoldfish - (SHA1 hashes, Yara rules) [Trendmicro Report](http://blog.trendmicro.com/trendlabs-security-intelligence/operation-woolen-goldfish-when-kittens-go-phishing/)
  - OpCleaver (Iranian APT campaign) - Source: [Cylance](http://www.cylance.com/operation-cleaver/)
  - More than 180 hack tool Yara rules - Source: [APT Scanner THOR](http://www.bsk-consulting.de/apt-scanner-thor/)
  - More than 600 web shell Yara rules - Source: [APT Scanner THOR](http://www.bsk-consulting.de/apt-scanner-thor/)
  - Numerous suspicious file name regex signatures - Source: [APT Scanner THOR](http://www.bsk-consulting.de/apt-scanner-thor/)
  - Much more ... (cannot update the list as fast as I include new signatures)

Loki is the new generic scanner that combines most of the features from my recently published scanners: [ReginScanner](https://github.com/Neo23x0/ReginScanner) and [SkeletonKeyScanner](https://github.com/Neo23x0/SkeletonKeyScanner).

## Requirements

No requirements if you use the compiled EXE.

If you want to build it yourself:

- [yara](http://goo.gl/PQjmsf) : It's recommended to use the most recent version of the compiled packages for Windows (x86) - Download it from here: http://goo.gl/PQjmsf
- [scandir](https://github.com/benhoyt/scandir) : faster alternative to os.walk()
- [colorama](https://pypi.python.org/pypi/colorama) : to color it up
- [psutil](https://pypi.python.org/pypi/psutil) : process checks
- [pywin32](http://sourceforge.net/projects/pywin32/) : path conversions (PyInstaller [issue](https://github.com/pyinstaller/pyinstaller/issues/1282); Windows only)

## Usage

    usage: loki.exe [-h] [-p path] [-s kilobyte] [--printAll] [--noprocscan]
                    [--nofilescan] [--noindicator] [--debug]

    Loki - Simple IOC Scanner

    optional arguments:
      -h, --help     show this help message and exit
      -p path        Path to scan
      -s kilobyte    Maximum file site to check in KB (default 2000 KB)
      --printAll     Print all files that are scanned
      --noprocscan   Skip the process scan
      --nofilescan   Skip the file scan
      --noindicator  Do not show a progress indicator
      --debug        Debug output

## Screenshots

Loki Scan

![Screen](/screens/lokiscan2.png)

Regin Matches

![Screen](/screens/lokiscan1.png)

Regin False Positives

![Screen](/screens/lokiscan3.png)

Hash based IOCs

![Screen](/screens/lokiconf1.png)

File Name based IOCs

![Screen](/screens/lokiconf2.png)

Generated log file

![Screen](/screens/lokilog1.png)

## Contact

LOKI scanner on our company homepage
[http://www.bsk-consulting.de/loki-free-ioc-scanner/](http://www.bsk-consulting.de/loki-free-ioc-scanner/)

Twitter
[@cyb3rOps](https://twitter.com/Cyb3rOps)
[@thor_scanner](https://twitter.com/thor_scanner)

If you are interested in a corporate solution for APT scanning, check out Loki's big brother [THOR](http://www.bsk-consulting.de/apt-scanner-thor/).

# Antivirus - False Positives

The compiled scanner may be detected by antivirus engines. This is caused by the fact that the scanner is a compiled python script that implement some file system and process scanning features that are also used in compiled malware code.

If you don't trust the compiled executable, please compile it yourself.

## Compile the Scanner

Download PyInstaller, switch to the pyinstaller program directory and execute:

    python ./pyinstaller.py -F C:\path\to\loki.py

This will create a `loki.exe` in the subfolder `./loki/dist`.

## Pro Tip (optional)

To include the msvcr100.dll to improve the target os compatibility change the line in the file `./loki/loki.spec` that contains `a.bianries,` to the following:

    a.binaries + [('msvcr100.dll', 'C:\Windows\System32\msvcr100.dll', 'BINARY')],

# License

Loki - Simple IOC Scanner
Copyright (c) 2015 Florian Roth

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see [http://www.gnu.org/licenses/](http://www.gnu.org/licenses/)
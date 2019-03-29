# How To Do Quick Forensics on Mac

Similarly to the instructions for [Windows](#windows-intro) the process to identify a potential infection on a Mac computer is:

1. Check for suspicious programs starting automatically
2. Check for suspicious running processes
3. Check for suspicious kernel extensions

The website [Objective-See](https://objective-see.com) provides several freeware utilities that facilitate this process.

- [KnockKnock](https://objective-see.com/products/knockknock.html) can be used to identify all programs that are registered to start automatically.
- [TaskExplorer](https://objective-see.com/products/taskexplorer.html) can be used to check running processes and identify those that look suspicious (for example because not signed, or because they are flagged by VirusTotal).
- [KextViewr](https://objective-see.com/products/kextviewr.html) can be used to identify any suspicious kernel extension that is loaded on the Mac computer.

In case these do not reveal anything immediately suspicious and you want to perform further triaging you could use [Snoopdigg](https://github.com/botherder/snoopdigg). Snoopdigg is an utility that simplifies the process of collecting some information on the system and take a full memory snapshot.

An additional tool that could be useful to collect further details (but that require some familiarity with terminal commands) is [AutoMacTC](https://www.crowdstrike.com/blog/automating-mac-forensic-triage/) by American cybersecurity company CrowdStrike.

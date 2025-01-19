## Open Firewall Access for MDM agent on port 443

The script determines what is the top level process that is blocked and adds a rule to allow it to access the internet on port 443.

The current version of the script does not use the address parameter because the actual Hexnode backend IP addresses are variable. The script uses the process name to allow the process to access the entire internet on port 443.
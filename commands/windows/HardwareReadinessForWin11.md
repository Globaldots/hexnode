## HardwareReadinessForWin11 script
The script runs on the remote PC and checks if the hardware is ready for Windows 11. 


The script checks the following requirements:
* TPM
* Secure Boot
* CPU
* RAM
* Storage

After the evaluation, the script optionally calls back to the Hexnode server with the results.

### Installation and preparations for usage
* Upload the script `HardwareReadinessForWin11.ps1` to your Hexnode content repository.
* Have an API key avaliable
* Prepare a custom report, filtered by "OS Name" that should contain "Windows 10"
* Prepare a dynamic group, filtered by "OS Name" that should contain "Windows 10". The dynamic group will be used to execute the script on its members rather that individually.
* Ensure that the field "Device note" is included in the report, as it will be used to store the results of the script.
* The script may fail to complete if the Windows firewall is blocking apps from outbound HTTPS connections on port 443. If that happens, run [the script to open port 443](open-firewall-access-443.ps1) for the Hexnode agent.

### Usage
Execute the script on the remote PC. The script will check the requirements and optionally call back to the Hexnode server with the results.
To get the results back into Hexnode, every execution must include the following parameters:

``
-DeviceID "%deviceid%" -APIKey YOUR-API-KEY -HexnodeInstance YOUR-INSTANCE
``

Replace YOUR-API-KEY with your Hexnode API key and YOUR-INSTANCE with your Hexnode instance name (the subdomain before hexnodemdm.com in the URL).

If the parameters are missing, the scripty still runs and its results will be available to view in the device actions.

### Credits
* https://www.ninjaone.com/script-hub/windows-11-compatibility-check-powershell/
* https://techcommunity.microsoft.com/t5/microsoft-endpoint-manager-blog/understanding-readiness-for-windows-11-with-microsoft-endpoint/ba-p/2770866
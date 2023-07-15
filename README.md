<p align="center"><img width=10% src="https://i.imgur.com/mCHUPgS.png"></p>

<p align="center">Within the grand expanse of the online gaming universe, a notorious entity darkens the landscape. Garnering a reprehensible reputation within the Arma 3 community, this individual is now extending their claws into FiveM, a much-loved platform for modding Grand Theft Auto V. Their wake is characterized by deceit, malfeasance, and unscrupulous tactics, distorting the virtuous spirit of the gaming world.</p>

<p align="center">Their operation, too generous a term for such a sordid endeavor, revolves around running gaming servers. Having blighted the Arma 3 realm, they're embarking on a new journey by launching a FiveM server. Beneath the allure of offering engaging gameplay experiences with missions, frameworks, and scripts, the ugly reality emerges - their content teems with stolen or dubiously procured scripts and mods. Intellectual property rights are trampled upon with brazen indifference, exhibiting a shocking disregard for the basic principles of creative respect.</p>

<p align="center">Their insidious practices are far from being confined to intellectual theft. They unleash chaos and disruption by employing a range of malicious tactics. From DDoS attacks, defamation campaigns, to player poaching, they exploit every dirty trick in the book to carve out their tainted niche. Artificially inflating server activity, they resort to manipulation and deception to project an illusion of popularity.</p>

<p align="center">Internally, their actions towards their own staff and players are equally abhorrent. They perpetuate an atmosphere of mistrust and fear through the leaking of personal information and rampant intimidation. They willingly throw their own people under the bus, dodging potential backlash amidst a web of deception spun with counterfeit content and false promises.</p>

<p align="center">Despite echoing empty vows of change, their morally bankrupt actions persist. Having exploited the Arma 3 community, they are now primed to infiltrate FiveM, dragging their tarnished legacy of deceit along. Their actions are a bleak reminder of the darker underbelly of the digital gaming world, compelling us all to remain vigilant and proactive.</p>

<p align="center">While retribution might not sit comfortably with all, it becomes a necessary measure when faced with such rampant exploitation. This is not just about personal grievances; it's about defending the rights of countless creators whose work has been unceremoniously hijacked. It's about upholding the dignity of every painstakingly written line of code, about preserving the foundational principles of integrity and decency in our gaming world. Be it in Arma 3, FiveM, or any other digital realm, this is a battle that calls for our united stand against foul play, for the gaming communities that value fairness and mutual respect above all.</p>

# Local Server Install Guide
This is a guide on how to get started with a local server. If you haven't done so already familiarize yourself with the "Required programs, downloads, and important URLs" section of the readme. If you have any questions or get stuck on trying to get up and running feel free to message Josh, Jordan, or Dave for assistance.
- Clone the repo to your desired location.
- After this create a folder named ```source```  in your directory.
- Make a COPY of ```devresources.cfg.md``` & ```devserver.cfg.md``` without deleting them. 
- When you have completed the previous step rename the copies you made to ```resources.cfg``` & ```server.cfg```. It should appear like this when done. [Example](https://goresee.com/w/b9c60414-df1b-4b4e-b5c3-5ad1e07a80af)
- After you have made your copies you need to make a server key on [Keymaster](https://keymaster.fivem.net) and place it at the top of the ```server.cfg``` file next to ```sv_licenseKey "PUT_YOUR_KEY_HERE"```. 
- It should look something like this.
```sv_licenseKey "cfxk_1Aj4XytPxbFeQEGfZ3PRE"```
- [Download](https://runtime.fivem.net/artifacts/fivem/build_server_windows/master/) the latest artifact from fivem. Please refrain from using the "latest recommended" and "latest optional" buttons at the top of the website as they tend to be out of date. 
- Make another folder called ```fxserver``` and put the artifact you downloaded from the previous step in the folder you created ```fxserver``` [Example](https://goresee.com/w/b9c60414-df1b-4b4e-b5c3-5ad1e07a80af)
- Your folder structure should appear like this after the previous steps have been completed. 
```
Fivem-Project
            ↓
            fxserver, source, anzus-project.sql, README.md
                        ↓ 
                        resources, devresources.cfg, devserver.cfg, myLogo.png, resources.cfg, server.cfg
```
- Run the exe ```FXServer.exe``` in the ```fxserver``` folder
- Link your fivem account in the browser it opens
- Make your local backup password this will not push to github as its in the gitignore file.
- When it asks you to make a server name you can make it whatever you want it will not change the main github.
- In step 3 of the txadmin setup click ```Existing Server Data``` and direct it to your ```source``` folder with the ```server.cfg``` you created this in step 2
- Go into your txadmin panel it is generally found in your browser [redirect](http://localhost:40120/) and head to your settings panel then ```FXServer``` tab and make sure under the ```OneSync``` sub section it is set to ```On (with infinity)``` and then under the "Additional Arguments" sub section type ```+set sv_enforceGameBuild 2372``` [Example](https://goresee.com/w/b9c60414-df1b-4b4e-b5c3-5ad1e07a80af)
- The last step is to make sure you have system permissions in the bottom of your server.cfg and in the permissions table in the sql database.
- Congratulations! You may now start your local dev server.

⠀
⠀
⠀
⠀
⠀
⠀


# Required programs, downloads, and important URLs
- [Artifacts](https://runtime.fivem.net/artifacts/fivem/build_server_windows/master/) you should update your fxserver regularly
- [Xampp](https://www.apachefriends.org/index.html) this is a good option for MySQL
- [txAdmin](http://localhost:40120/) link to your panel
- [Keymaster](https://keymaster.fivem.net) hold your server keys linked to your fivem account
- [Codewalker](https://cdn.discordapp.com/attachments/351357358460370944/932650580353114122/CodeWalker30_dev41.zip) used for editing map items
- [ToolKitV](https://github.com/UmbrellaRE/ToolKitV) good for optimizing textures but can mess up your files
- [OpenIV](https://openiv.com/WebIV/guest.php?get=1) used for browsing gta files and models (you can use codewalker for this as well)
- [Heidi](https://www.heidisql.com/download.php) used for running your sql database
- [VSCode](https://code.visualstudio.com/) recommended code editior
- [PlebMaster](https://forge.plebmasters.de/) used for finding unknown hashes and directories


# Simple cache cleaners
- This is a .bat that can clear your server cache make sure you set to your directory
```
@echo off
taskkill /f /im FXServer.exe
rmdir /s /q "C:\Users\admin\Desktop\Anzus-Fivem-Project\source\cache"      <-----------Set your directory
cls
```

- This is .bat that can clear your CLIENT side cache.
```
@echo off
rmdir /s /q "%LocalAppData%\FiveM\FiveM.app\data\cache"
rmdir /s /q "%LocalAppData%\FiveM\FiveM.app\data\server-cache"
rmdir /s /q "%LocalAppData%\FiveM\FiveM.app\data\server-cache-priv"
rmdir /s /q "%LocalAppData%\FiveM\FiveM.app\logs"
rmdir /s /q "%LocalAppData%\FiveM\FiveM.app\crashes"
powercfg -s 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
taskkill /f /im GTAVLauncher.exe
wmic process where name="FiveM.exe" CALL setpriority 128
wmic process where name="FiveM_b2189_GTAProcess.exe" CALL setpriority 128
cls

```


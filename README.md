<img src="https://github.com/farique1/attract-mode-list-statistics/blob/master/Images/GitHub_AMLS_Logo-02.png" alt="Attract Mode List Statistics" width="290" height="130">  
# Attract Mode List Statistics

## What it is.

**Attract Mode List Statistics**  help you organise the assets on your **Attract Mode** installation.  
**AMLS** identify the assets you are missing and the ones you have that are not being used on your **Attract Mode** setup based on your ROM collection.  

**AMLS**  look for the following assets and entries and compare them with the ROMS registered on your romlists to show what you have, are missing or are not using.

- **ROMs**: The roms per si, based on the extensions registered on **AM**.
**AMLS** cannot deal with `<DIR>` for now.
- **Snaps** (Screenshots): **AMLS** will search for `.jpg .jpeg .png .gif .bmp .tga`
- **Flyers** (Box Art): **AMLS** will search for `.jpg . jpeg .png .gif .bmp .tga`
- **Overviews**: Overviews on the romlists subfolders.
- **Publishers**: The publishers/manufacturers on the romlist.
- **Year**: The years on the romlist.
**AMLS** will not consider valid years with non-number characters.
- **Category**: The category/genre on the romlist.


## How to use.  

>**AMLS** need to be on the same folder as its `Data` subfolder.  

![#gui](https://github.com/farique1/attract-mode-list-statistics/blob/master/Images/gui.png)

Following the main interface, from left to right, the controls are:  

- *Attract Mode Path button:*  
To point to your Attract Mode installation path. **AMLS** will read the "emulators" folders and use the `.cfgs` there to gather information and collect all the data it needs. It will find your assets folders if they are configured on **Attract Mode**. When you choose the correct path, it will automatically start the scanning process.  
	> It still cannot differentiate between the emulators you are actually using on **AM** and the ones you are not, so for the sake of cleanness you can move the .`cfgs` of the emulators you are not using to a subfolder.

- *Rescan All button:*  
Performs a fresh scan on the path saved. Useful when you have changed something on AM and want it updated on **AMLS**. A partial log file is saved on the Data subfolder.  

- *AM v2.4 Overviews*  
If checked, **AMLS** will look for the `.txt` overviews on Attract mode 2.4, otherwise it will look for v2.3 `.cfg`.

- *Save button:*  
Save the current data so you don't need to scan every time you open **AMLS**. If there is data saved, **AMLS** will use it when opened. If you perform a Rescan, you must Save the data before closing or you will lose it.  

- *Help button:*  
Open this (hopefully)  

- *Systems (emulators) list:*  
Show a list of the emulators you currently have on the `emulators` folder on **AM**. **AMLS** still cannot differentiate between the emulators you are actually using on **AM** and the ones you are not, so for the sake of cleanness you can move the `.cfgs` of the emulator you are not using to a subfolder and **AMLS** will not see them.  
Click on the names to select the emulator you want to check.  

- *Sys config info button:*  
Show the **AM** configuration of the currently selected emulator pertaining to **AMLS**.  

- *Main display area:*  
Show the currently selected emulator information. **AMLS** will gather the following information regarding the previously mentioned assets:  

  - **Have**: All the assets **AMLS** was able to find.  
  - **Missing**: The assets **AMLS** was NOT able to find or where blank on the romlist.  
  - **Percent**: The percentage of each asset you have.  
  - **Left**: The that do NOT have associated ROMs on the romlist.  

  The bars on the left offer a visual representation of the percentage/completion of each asset you have. The topmost bar along with the topmost percentage number show the completion/percentage of all the assets combined.  
By clicking on the numbers on the right you can open a list with the names of the actual roms regarding the specific asset/statistic you want to see. The percent Colum do not open a list and you also cannot open a list with zero elements. You can open up to 10 lists simultaneously (more on the lists below.)  

- *Arrow < > buttons:*  
Select the previous and next emulator.  

- *Save date indicator:*  
Show the last time you saved the data on AMLS.  

- *Exit button:*  
Exit the program. if you have unsaved data it will ask you to save before closing.  


## The asset lists  

When you click a valid number on the right side of the main display area, **AMLS** will open a list showing the roms regarding that statistic.  

From top to bottom.  

- *The title:*  
Shows the emulator being listed.  

- *Labels:*  
Shows the statistic being displayed and the number of items on the list.  

- *The actual list:*  
Shows the rom names regarding this asset/statistic.  

- *Copy button:*  
Sends the list to the clipboard.  

- *Export button:*  
Saves the list.  

- *Show Titles.*  
Shows the rom names along with the TITLES associated to it on the romlist. Depending on the number of roms this may take a while to open.  

## Acknowledgements  

Enjoy and send feedback.  
Thanks.  

***AMLS** is offered as is with no guaranties whatsoever. We (I) will not be responsible for any harm it decides to do to your romlists, assets, Attract Mode, operating system, computer or life. I think, though, it will behave (mostly)*

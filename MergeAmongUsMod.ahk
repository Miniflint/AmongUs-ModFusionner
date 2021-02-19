Counter := 0
Gui, Add, Progress, w200 h20 cGreen vMyProgress
if (fileExist( "C:\Program Files (x86)\Steam\steamapps\common\Among Us"),D)
{
    AmongUsPathSteam = C:\Program Files (x86)\Steam\steamapps\common
    FileRead(AmongUsPathSteam)
}
else if (FileExist("C:\Program Files\Epic Games\Among Us"),D)
{
    AmongUsPathEpic = C:\Program Files\Epic Games
    FileRead(AmongUsPathEpic)
}
else if (FileExist("D:\SteamLibrary\steamapps\common\Among Us"),D)
{
    AmongUsPathDriverD = C:\Program Files\Epic Games
    FileRead(AmongUsPathDriverD)
}
else if !(FileExist("D:\SteamLibrary\steamapps\common\Among Us"),D)
{
    IniFolderFile = C:\Users\%A_UserName%\AppData\Roaming\AmongUsStartingFolder.ini
    if !(FileExist(IniFolderFile))
    {
        FileSelectFolder, NothingFound,,, Select the folder where your among us mods are located
        StringGetPos, pos, NothingFound , \, R
        pos++
        StringTrimLeft, AfterNothingFound, NothingFound, %pos%
        if NothingFound = 
            IniFileDelete(IniFolderFile, 2)
        else if AfterNothingFound = Among Us
            IniFileDelete(IniFolderFile, 5)
        else
        {
            IniWrite, %NothingFound%, %IniFolderFile%, PathFolder, File
            FileRead(NothingFound)
        }
    }
    else
    {
        IniRead, FromIniFolder, %IniFolderFile%, PathFolder, File, ERROR
        if FromIniFolder = ERROR
            IniFileDelete(IniFolderFile, 4)
        else
            FileRead(FromIniFolder)
    }
}
FileRead(StartingFolder)
{
    inputbox, ModsNumber, Mods Fusionner, how much mods do you wanna merge ?
    IniFolderFile = C:\Users\%A_UserName%\AppData\Roaming\AmongUsStartingFolder.ini
    if ModsNumber = 
        IniFileDelete(IniFolderFile, 1)
    else
    {
        Files = 0
        Loop, %ModsNumber%
        {
            FileSelectFolder, FileNB, %StartingFolder%
                if FileNB = 
                    IniFileDelete(IniFolderFile, 2)
            IniWrite, %FileNB%, %IniFolderFile%, AmongUsPath, %Files%
            Files++
        }
        InputBox, FileName, Name the folder, Name the among us folder (it will be the name of the among us shortcut)
        if FileName = 
            IniFileDelete(FileNB, 3)
        else
        {
            Gui, Show
            FileCreateDir, %StartingFolder%\%FileName%
            CounterNumber := 100/ModsNumber
            Counter := CounterNumber
            Files = 0
            Loop, %ModsNumber%
            {
                IniRead, IniAmongUsPathRead, %IniFolderFile%, AmongUsPath, %Files%, ERROR
                if IniAmongUsPathRead = ERROR
                    IniFileDelete(IniFolderFile, 4)
                else
                {
                    Filecopydir, %IniAmongUsPathRead%, %StartingFolder%\%FileName%, 1
                    GuiControl,, MyProgress, % Counter
                    Counter += CounterNumber
                    Files++
                }
            }
            Gui Destroy
            FileCreateShortcut, %StartingFolder%\%FileName%\Among us.exe, %A_desktop%\%FileName%.lnk
            IniDelete, %IniFolderFile%, AmongUsPath
            MsgLoop()
            exitapp
        }
    }
}
IniFileDelete(FileIni, nb)
{
    if nb = 1
        Msgbox, you haven't sent a number
    else if nb = 2
        Msgbox, you haven't selected a folder
    else if nb = 3
        msgbox, you haven't named the folder
    else if nb = 4
        msgbox, there is an ERROR
    else if nb = 5
        msgbox, you selected the among us folder - not the folder WHERE Among Us IS
    IniDelete, %FileIni%, AmongUsPath
    exitapp
}
MsgLoop()
{
    MsgBoxSec = 5
    Loop, %MsgBoxSec%
    {
        MsgBox,, installation statut, Installation completed`n the windows will disapear in %MsgBoxSec%, 1
        ifmsgbox Ok
            exitapp
        if msgbox Close
            exitapp
        MsgBoxSec := MsgBoxSec-1
    }
}

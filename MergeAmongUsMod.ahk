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
    AmongUsStartingFolder = C:\Users\%A_UserName%\AppData\Roaming\AmongUsStartingFolder.ini
    if !(FileExist(AmongUsStartingFolder))
    {
        FileSelectFolder, NothingFound,,, Select the folder where your among us mods are located
        StringGetPos, pos, NothingFound , \, R
        pos++
        StringTrimLeft, AfterNothingFound, NothingFound, %pos%
        if NothingFound = 
        {
            Msgbox, You haven't selected anything
            exitapp
        }
        else if AfterNothingFound = Among Us
        {
            msgbox, you selected the among us folder - not WHERE the among us folder is located
            exitapp
        }
        else
        {
            IniWrite, %NothingFound%, %AmongUsStartingFolder%, PathFolder, File
            FileRead(NothingFound)
        }
    }
    else
    {
        IniRead, FromIniFolder, %AmongUsStartingFolder%, PathFolder, File, ERROR
        if FromIniFolder = ERROR
        {
            IniDelete, %AmongUsStartingFolder%, PathFolder
            msgbox, there is an error. please retry
        }
        else
        {
            FileRead(FromIniFolder)
        }
    }
}


FileRead(StartingFolder)
{
    FileTemp = C:\Users\%A_UserName%\AppData\Roaming\temp.txt
    inputbox, ModsNumber, Mods Fusionner, how much mods do you wanna merge ?
    if ModsNumber = 
    {
        Msgbox, You haven't named the folder
        exitapp
    }
    else
    {
        Loop, %ModsNumber%
        {
            FileSelectFolder, FileNB, %StartingFolder%
            FileAppend,
            (
                %FileNB%`n
            ), %FileTemp%
        }
        InputBox, FileName, Name the folder, Name the among us folder (it will be the name of the among us shortcut)
        if FileName = 
        {
            Msgbox, You haven't named the folder
            FileDelete, %Filetemp%
            exitapp
        }
        else
        {
            Gui, Show
            FileCreateDir, %StartingFolder%\%FileName%
            CounterNumber := 100/ModsNumber
            Counter := CounterNumber
            Loop, read, %FileTemp%
            {
                Loop, parse, A_LoopReadLine, %A_Tab%,
                {
                        Filecopydir, %A_LoopField%, %StartingFolder%\%FileName%, 1
                        GuiControl,, MyProgress, % Counter
                        Counter += CounterNumber
                }
            }
            Gui Destroy
            FileCreateShortcut, %StartingFolder%\%FileName%\Among us.exe, %A_desktop%\%FileName%.lnk
            FileDelete, %FileTemp%
            MsgLoop()
            exitapp
        }
    }
}

MsgLoop()
{
    MsgBoxSec = 5
    Loop, %MsgBoxSec%
    {
        MsgBox,, installation statut, Installation completed`n the windows will disapear in %MsgBoxSec%, 1
        ifmsgbox Ok
        {
            exitapp
        }
        if msgbox Close
        {
            exitapp
        }
        MsgBoxSec := MsgBoxSec-1
    }
}

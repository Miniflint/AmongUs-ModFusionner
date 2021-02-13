if (fileExist( "C:\Program Files (x86)\Steam\steamapps\common\Among Us"),D)
{
    AmongUsPathSteam = C:\Program Files (x86)\Steam\steamapps\common
    GETUSERINPUT(AmongUsPathSteam)
}
else if (FileExist("C:\Program Files\Epic Games\Among Us"),D)
{
    AmongUsPathEpic = C:\Program Files\Epic Games
    GETUSERINPUT(AmongUsPathEpic)
}
else if (FileExist("D:\SteamLibrary\steamapps\common\Among Us"),D)
{
    AmongUsPathDriverD = C:\Program Files\Epic Games
    GETUSERINPUT(AmongUsPathDriverD)
}
else if !(FileExist("D:\SteamLibrary\steamapps\common\Among Us"),D)
{
    msgbox, 0, Une fenetre va arriver, selectionnez le dossier dans lequel se trouve les mods a fusionner
    GETUSERINPUT(NothingFound)
}

GETUSERINPUT(FolderStart)
{
    FileSelectFolder, FDirectory, %FolderStart% ,, Selectionnez le premier dossier
    FileSelectFolder, SDirectory, %FolderStart% ,, Selectionnez le Deuxieme dossier
    InputBox, FileName, Nommez le dossier, Donnez un nom au dossier pour la fusion des mods
    FileFusion(FDirectory, SDirectory, FileName, FolderStart)
}  

FileFusion(FirstDirectory, SecondDirectory, DirName, PathFolder)
{
    FileCopydir, %FirstDirectory%, %PathFolder%\%DirName%, 1   
    FileCopydir, %SecondDirectory%, %PathFolder%\%DirName%, 1
    FileCreateShortcut, %PathFolder%\%DirName%\Among Us.exe, %A_DESKTOP%\Mod Among us - %DirName%.lnk
}

-- xmonad config file
-- jazen, feb '10
--

import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

main = do
  -- Start dzen
  statusBarPipe <- spawnPipe statusBarCmd

  xmonad $ defaultConfig 
    -- Add support for status bar and docks
    { manageHook     = manageDocks <+> manageHook defaultConfig
    , layoutHook     = avoidStruts  $  layoutHook defaultConfig

    , borderWidth    = 1
    , workspaces     = myWorkspaces

    -- Configure pretty printing to the statusbar
    , logHook        = dynamicLogWithPP $ myStatusPP statusBarPipe

    -- Rebind Mod to the Windows key
    , modMask        = mod4Mask
    } `additionalKeys`

    -- Take screenshot with Printscreen
    [ ((0, xK_Print), spawn "scrot")
    ]

-- Workspaces ------------------------------------------

myWorkspaces :: [String]
myWorkspaces = [ "1:shop", "2:fg", "3:web", "4:chat", "5:other" ]

-- Statusbar -------------------------------------------

statusBarCmd :: String
statusBarCmd = "dzen2" ++
               " -bg '" ++ colorDarkGray ++ "'" ++
               " -fg '" ++ colorLightGray ++ "'" ++
               " -sa 1" ++
               " -fn '" ++ barXFont ++ "'" ++
               " -ta 1 -e ''"

myStatusPP h = defaultPP { 
                 ppCurrent = dzenColor colorWhite colorLightBlue
               , ppTitle   = dzenColor colorYellow colorDarkGray
               , ppOutput  = hPutStrLn h
               }

-- Theme -----------------------------------------------

colorBlack     = "#000000"
colorDarkGray  = "#222222"
colorLightGray = "#aaaaaa"
colorWhite     = "#ffffff"
colorLightBlue = "#0066ff"
colorYellow    = "#fdfd00"

barFont, barXFont :: [Char]
barFont        = "terminus"
barXFont       = "-*-terminus-medium-r-normal--12-*-*-*-*-*-*-*"


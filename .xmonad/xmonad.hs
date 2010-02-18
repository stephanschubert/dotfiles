-- xmonad config file
-- jazen, feb '10
--

import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks

import XMonad.Layout
import XMonad.Layout.Accordion
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Tabbed
import XMonad.Layout.LayoutHints
import XMonad.Layout.ResizableTile
import XMonad.Layout.ThreeColumns

import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

main = do
  -- Start dzen
  statusBarPipe <- spawnPipe statusBarCmd

  xmonad $ defaultConfig 
    -- Add support for status bar and docks
    { manageHook     = manageDocks <+> manageHook defaultConfig
    , layoutHook     = myLayout

    , borderWidth        = 1
    , focusedBorderColor = colorFocusedBG
    , normalBorderColor  = colorBlack
    , workspaces         = myWorkspaces

    -- Configure pretty printing to the statusbar
    , logHook        = dynamicLogWithPP $ myStatusPP statusBarPipe

    -- Rebind Mod to the Windows key
    , modMask        = mod4Mask
    } `additionalKeys`

    -- Take screenshot with Printscreen
    [ ((0, xK_Print), spawn "scrot")
    ]

-- Workspaces ------------------------------------------------------------------

myWorkspaces :: [String]
myWorkspaces = [ "1:shop", "2:fg", "3:web", "4:comm", "5:other" ] ++ map show [6..9]

-- Layouts ---------------------------------------------------------------------

myLayout = avoidStruts (tiled' ||| ThreeCol 2 (3/100) (1/2)) ||| Full
  where
    -- The default number of windows in the master pane
    nmaster  = 1
    -- Default proportion of screen occupied by master pane
    ratio    = 1/2
    -- Percent of screen to increment by when resizing panes
    delta    = 2/100
    -- Shorthand for ResizableTall
    tiled'   = ResizableTall nmaster delta ratio []

-- Statusbar -------------------------------------------------------------------

statusBarCmd :: String
statusBarCmd = "dzen2" ++
               " -bg '" ++ colorNormalBG ++ "'" ++
               " -fg '" ++ colorNormalFG ++ "'" ++
               " -sa l" ++
               " -fn '" ++ barXFont ++ "'" ++
               " -ta l -e ''"

myStatusPP handle = defaultPP { 
  ppCurrent = wrap("^fg(" ++ colorFocusedFG ++ ")^bg(" ++ colorFocusedBG ++ ") ") " ^fg()^bg()"
, ppUrgent  = wrap("^fg(" ++ colorUrgentFG ++ ")^bg(" ++ colorUrgentBG ++ ")") "^fg()^bg()"
, ppVisible = wrap("^fg(" ++ colorNormalFG ++ ")^bg(" ++ colorNormalBG ++ ")") "^fg()^bg()"
, ppHidden  = wrap("^fg(" ++ colorNormalFG ++ ")^bg(" ++ colorNormalBG ++ ")") "^fg()^bg()"
, ppHiddenNoWindows  = wrap("^fg(" ++ colorUnimportantFG ++ ")^bg(" ++ colorUnimportantBG ++ ")") "^fg()^bg()"
, ppSep     = "^fg(" ++ colorSeperator ++ ")^r(5x5)^fg()"
, ppTitle   = wrap("^fg(" ++ colorHighlight ++ ")") "^fg()"
, ppLayout  = const ""
, ppOutput  = hPutStrLn handle
}

-- Theme -----------------------------------------------------------------------

colorBlack     = "#000000"

colorFocusedFG = colorBlack
colorFocusedBG = "#a8df36"

colorUrgentFG  = "#ffffff"
colorUrgentBG  = "#ff0000"

colorNormalFG  = "#aaaaaa"
colorNormalBG  = "#222222"

colorUnimportantFG = "#666666"
colorUnimportantBG = colorNormalBG

colorSeperator = colorNormalBG
colorHighlight = colorUrgentFG


barFont, barXFont :: [Char]
barFont        = "terminus"
barXFont       = "-*-terminus-medium-r-normal--12-*-*-*-*-*-*-*"


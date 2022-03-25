import XMonad
import Data.Monoid
import System.Exit
import qualified XMonad.StackSet as W
import qualified Data.Map	       as M
import XMonad.Hooks.ManageDocks
  ( avoidStruts, docks, manageDocks, Direction2D(D, L, R, U) )
import XMonad.Util.Run
import XMonad.Util.SpawnOnce ( spawnOnce )
import XMonad.Hooks.DynamicLog
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing ( spacingRaw, Border(Border) )
import XMonad.Layout.Gaps
  ( Direction2D(D, L, R, U),
    gaps,
    setGaps )

_modMask = mod4Mask
_terminal = "alacritty"
_borderWidth = 2

--Keys
_keys conf@(XConfig {XMonad.modMask = mm}) = M.fromList $
	[ ((mm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf) 
	, ((mm, xK_d), spawn "dmenu_run") 
  , ((mm, xK_b), spawn "firefox")
	, ((mm, xK_x), kill) 
	, ((mm, xK_q), spawn "xmonad --recompile; xmonad --restart")
  ]
  ++

  --Workspaces
  [((m .|. mm, k), windows $ f i)
      | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_4]
      , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

--Mouse
_mouseBindings (XConfig {XMonad.modMask = mm}) = M.fromList $
	[ ((mm, button1), (\w -> focus w >> mouseMoveWindow w
					 >> windows W.shiftMaster))
	, ((mm, button2), (\w -> focus w >> windows W.shiftMaster))
	, ((mm, button3), (\w -> focus w >> mouseResizeWindow w
					 >> windows W.shiftMaster)) ]
 
--ManageHook
_manageHook = composeAll
	[ className =? "Firefox"        --> doFloat 
  , resource =? "desktop_window" 	--> doIgnore
	, resource =? "kdesktop"        --> doIgnore ]

--Layout
_layout = avoidStruts (Tall 1 (3/100) (1/2) ||| Full)

--Events
_eventHook = mempty

--Startup
_startup = do
  spawnOnce "picom --experimental-backends"

--Log
_logHook = dynamicLog

--Main
main = do
	xproc <- spawnPipe "xmobar -x 0 /home/user/.config/xmobar/.xmobarrc"
	xmonad $ docks defaults

defaults = def {
	modMask 	= _modMask,
	terminal 	= _terminal,
	borderWidth 	= _borderWidth,
	
	keys 		= _keys,
	mouseBindings 	= _mouseBindings,
	layoutHook 	= gaps [(L,20), (R,20), (U,10), (D,20)] $ spacingRaw True (Border 10 10 10 10) True (Border 10 10 10 10) True $ smartBorders $ _layout,
	manageHook 	= _manageHook,
	handleEventHook = _eventHook,
	logHook 	= _logHook,
	startupHook 	= _startup
	}


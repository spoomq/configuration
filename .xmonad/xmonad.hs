import XMonad
import Data.Monoid
import System.Exit
import qualified XMonad.StackSet as W
import qualified Data.Map	 as M
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run
import XMonad.Hooks.DynamicLog

_modMask = mod4Mask
_terminal = "alacritty"
_borderWidth = 2

--Keys
_keys conf@(XConfig {XMonad.modMask = mm}) = M.fromList $
	[ ((mm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf) 
	, ((mm, xK_d), spawn "dmenu_run") 
	, ((mm .|. shiftMask, xK_c), kill) 
	, ((mm, xK_q), spawn "xmonad --recompile; xmonad --restart") ]


--Mouse
_mouseBindings (XConfig {XMonad.modMask = mm}) = M.fromList $
	[ ((mm, button1), (\w -> focus w >> mouseMoveWindow w
					 >> windows W.shiftMaster))
	, ((mm, button2), (\w -> focus w >> windows W.shiftMaster))
	, ((mm, button3), (\w -> focus w >> mouseResizeWindow w
					 >> windows W.shiftMaster)) ]
 
--ManageHook
_manageHook = composeAll
	[ resource =? "desktop_window" 	--> doIgnore
	, resource =? "kdesktop"	--> doIgnore ]

--Layout
_layout = avoidStruts (Tall 1 (3/100) (1/2) ||| Full)

--Events
_eventHook = mempty

--Startup
_startup = return ()

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
	
	layoutHook 	= _layout,
	manageHook 	= _manageHook,
	handleEventHook = _eventHook,
	logHook 	= _logHook,
	startupHook 	= _startup
	}


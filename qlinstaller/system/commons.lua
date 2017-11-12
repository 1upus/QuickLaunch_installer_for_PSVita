--[[ 
	QuickLanch Installer
	
	Licensed by GNU General Public License v3.0
	
	(c) 2017 by lupus
	based on sources from Team OneLua
]]

-- Loading and setting up sa0 fonts for translations
function setupfonts()
charfont = "sa0:data/font/pvf/psexchar.pvf"
cnfont = "sa0:data/font/pvf/cn0.pvf"
jpnfont = "sa0:data/font/pvf/jpn0.pvf"
ltnfont = "sa0:data/font/pvf/ltn4.pvf"
krfont = "sa0:data/font/pvf/kr0.pvf"
jpnpgf = "sa0:data/font/pgf/jpn0.pgf"

char_fnt = font.load(charfont)
if __LANG == "RUSSIAN" or __LANG == "POLISH"  then font.setdefault(ltnfont) else font.setdefault(jpnfont) end
end

-- Loading special glyphs (buttons, symbols, etc.)
function preloadsymbols()
 if char_fnt then -- Use oficial ps symbols. Will not work without preloaded psexchr.pvf font
SYMBOL_TRIANGLE   = " "
SYMBOL_CIRCLE	  = "!"
SYMBOL_CROSS	  = "\""
SYMBOL_SQUARE     = "#"
BTN_TRIANGLE      = "$"
BTN_CIRCLE        = "%"
BTN_CROSS  	      = "&"
BTN_SQUARE        = "'"
BTN_TRIANGLE_T    = "("  -- _T - transparent button
BTN_CIRCLE_T	  = ")"
BTN_CROSS_T       = "*"
BTN_SQUARE_T      = "+"
BTN_DPADUP        = ","
BTN_DPADDOWN      = "-"
BTN_DPADLEFT      = "."
BTN_DPADRIGHT     = "/"
BTN_L             = "0"
BTN_R             = "1"
STICK_L           = "2"
STICK_R           = "3"
BTN_SELECT        = "4"
BTN_START         = "5"
BTN_PS            = "6"
BTN_POWER         = "7"
BTN_VOLUP         = "8"
BTN_VOLDN         = "9"
SYMBOL_USB        = ":"
SYMBOL_CLOCK1     = ";"
SYMBOL_CLOCK2     = "<"
SYMBOL_HOME       = "="
SYMBOL_PIN        = ">"
SYMBOL_BACKSPACE  = "@"
SYMBOL_UPARROW    = "A"
SYMBOL_KEYBOARD   = "B"
SYMBOL_ENTER      = "C"
LOGO_PS           = "D"
LOGO_DNAS         = "E"
LOGO_ATRAC        = "F"
LOGO_PSPLUS       = "G"
 else char_fnt = font.load(jpnfont)
SYMBOL_TRIANGLE	  = string.char(0xe2)..string.char(0x96)..string.char(0xb3)
SYMBOL_CIRCLE	  = string.char(0xe2)..string.char(0x97)..string.char(0x8b)
SYMBOL_CROSS	  = string.char(0xe2)..string.char(0x95)..string.char(0xb3)
SYMBOL_SQUARE	  = string.char(0xe2)..string.char(0x96)..string.char(0xa1)
BTN_TRIANGLE      = string.char(0xe2)..string.char(0x96)..string.char(0xb3) -- button symbol is not exists in psp/psv fonts so you may need a trick: draw SYMBOL_CIRCLE bottom that SYMBOL_TRIANGLE AND at the same coords
BTN_CIRCLE        = string.char(0xe2)..string.char(0x97)..string.char(0x8e)
BTN_CROSS  	      = string.char(0xe2)..string.char(0x8a)..string.char(0x97)
BTN_SQUARE        = string.char(0xe3)..string.char(0x8b)..string.char(0xba)
BTN_TRIANGLE_T    = BTN_TRIANGLE
BTN_CIRCLE_T	  = BTN_CIRCLE
BTN_CROSS_T       = BTN_CROSS
BTN_SQUARE_T      = BTN_SQUARE
BTN_DPADUP        = string.char(0xe2)..string.char(0x87)..string.char(0xa7)
BTN_DPADDOWN      = string.char(0xe2)..string.char(0x87)..string.char(0xa9)
BTN_DPADLEFT      = string.char(0xe2)..string.char(0x87)..string.char(0xa6)
BTN_DPADRIGHT     = string.char(0xe2)..string.char(0x87)..string.char(0xa8)
BTN_L             = string.char(0xe2)..string.char(0x93)..string.char(0x81)
BTN_R             = string.char(0xe2)..string.char(0x93)..string.char(0x87)
STICK_L           = "L-Analog"                                              -- alt text only :/
STICK_R           = "R-Analog"
BTN_SELECT        = "Select"
BTN_START         = "Start"
BTN_PS            = "PS Button"
BTN_POWER         = string.char(0xe2)..string.char(0x93)..string.char(0x9b)
BTN_VOLUP         = string.char(0xe2)..string.char(0x8a)..string.char(0x95)
BTN_VOLDN         = string.char(0xe2)..string.char(0x8a)..string.char(0x96)
SYMBOL_USB        = string.char(0xe2)..string.char(0x87)..string.char(0x8c)
SYMBOL_CLOCK1     = "_"
SYMBOL_CLOCK2     = "_"
SYMBOL_HOME       = string.char(0xe2)..string.char(0xbe)..string.char(0x95)
SYMBOL_PIN        = string.char(0xe2)..string.char(0x98)..string.char(0x9f)
SYMBOL_BACKSPACE  = string.char(0xe2)..string.char(0x86)..string.char(0x90)
SYMBOL_UPARROW    = string.char(0xe2)..string.char(0x86)..string.char(0x91)
SYMBOL_KEYBOARD   = string.char(0xe2)..string.char(0x8a)..string.char(0x9e)
SYMBOL_ENTER      = string.char(0xe2)..string.char(0x86)..string.char(0x99)
LOGO_PS           = string.char(0xe3)..string.char(0x8e)..string.char(0xb0)
LOGO_DNAS         = "DNAS"
LOGO_ATRAC        = string.char(0xe2)..string.char(0x99)..string.char(0xab)
LOGO_PSPLUS       = LOGO_PS..string.char(0xe2)..string.char(0x9c)..string.char(0x9a)
 end

end

-- Install default QL data function
function modinstall01()
 buttons.homepopup(0)
 files.delete(__URPATH.."img")
 files.mkdir(__URPATH.."img/")
 files.delete(__URPATH.."whatsnew.xml")
 files.copy("resources/installer/app01.png",__URPATH.."img/")
 files.copy("resources/installer/app02.png",__URPATH.."img/")
 files.copy("resources/installer/app03.png",__URPATH.."img/")
 files.copy("resources/installer/whatsnew.xml",__URPATH)
 os.delay(500)
 buttons.homepopup(1)
 power.restart()
 end

-- Install user mod data function
function modinstall02()
 buttons.homepopup(0)
   if __APP01SHOW and __APP02SHOW and __APP03SHOW and __APP01PATH and __APP02PATH and __APP03PATH
    then
     --custom_msg(__APP01SHOW.." "..__APP01PATH.."\n\n"..__APP02SHOW.." "..__APP02PATH.."\n\n"..__APP03SHOW.." "..__APP03PATH,0)
	 custom_msg(__XMLS041,0)
    else
     custom_msg("ini error",0)
   end
 --files.delete(__URPATH.."img")
 --files.mkdir(__URPATH.."img/")
 --files.delete(__URPATH.."whatsnew.xml")
 --if files.exists(__UXPATH.."app01.png") then files.copy(__UXPATH.."app01.png",__URPATH.."img/") end
 --if files.exists(__UXPATH.."app02.png") then files.copy(__UXPATH.."app02.png",__URPATH.."img/") end
 --if files.exists(__UXPATH.."app03.png") then files.copy(__UXPATH.."app03.png",__URPATH.."img/") end
 --if files.exists(__UXPATH.."whatsnew.xml") then files.copy(__UXPATH.."whatsnew.xml",__URPATH)  end
 --os.delay(500)
 buttons.homepopup(1)
 --power.restart()
end

-- Reset mod data function
function modreset()
 files.delete(__URPATH.."img")
 files.mkdir(__URPATH.."img/")
 files.delete(__URPATH.."whatsnew.xml")
 os.delay(500)
 power.restart()
end

-- Preview default mod function
function modprev01()
 draw.fillrect(0,394,960,150, 0x64545353) --UP
 screen.print(10,404,strings.preview,1,color.white,color.blue,__ALEFT)
 if defapp01 then defapp01:blit(37,424) end 
 if defapp02 then defapp02:blit(339,424) end 
 if defapp03 then defapp03:blit(641,424) end 
end

-- Preview user mod function
function modprev02()
if userapp01 then userapp01:blit(40,436) end 
if userapp02 then userapp02:blit(339,436) end 
if userapp03 then userapp03:blit(641,436) end 
end

-- AppInstaller Function
function onAppInstall(step, size_argv, written, file, totalsize, totalwritten)

	buttons.homepopup(0)

	if back then back:blit(0,0) end

	if step == 2 then												--Confirmation
		os.delay(10)
		return 10 -- Ok
	elseif step == 4 then											-- Installing
	    draw.fillrect(0,0,960,30, 0x64545353) --UP
        screen.print(10,7,strings.caption.." v"..ver,1,color.white,color.blue,__ALEFT)
		screen.print(75,75,"Installing...",1,color.white,color.blue)
		screen.print(10,435,title, 0.9, color.white, color.green, __ALEFT)
		screen.print(10,470,version, 0.9, color.white, color.green, __ALEFT)
		screen.flip()
	end

	buttons.homepopup(1)

end

function init_msg(msg)
	if back then back:blit(0,0) end
	draw.fillrect(0,0,960,30, 0x64545353) --UP
	screen.print(10,7,strings.caption.." v"..ver,1,color.white,color.blue,__ALEFT)
	screen.print(70, 50, msg, 1.0, color.white, color.cyan:a(100))
	screen.flip()
	os.delay(10)
end


function custom_msg(printtext,mode)
	local buff = screen.toimage()
	if box then box:center() end

	for i=0,102,6 do

		if buff then buff:blit(0,0) end
		if box then
			box:scale(i)
			box:blit(960/2,544/2)
		end

		screen.flip()
	end

	xtext = 480 - (screen.textwidth(printtext)/2)
	xopt1 = 360 - (screen.textwidth(strings.option1_msg)/2)
	xopt2 = 600 - (screen.textwidth(strings.option2_msg)/2)

	buttons.read()
	local result = false
	while true do
		buttons.read()
		if buff then buff:blit(0,0) end
		if box then	box:blit(480,272) end

		screen.print(480,165, strings.title_msg, 1, color.white, color.gray, __ACENTER)
		screen.print(xtext,200, printtext,1, color.gray)

		if mode == 0 then
		    screen.print(char_fnt,xopt1+110,360, BTN_CROSS,1.02, color.gray) 
			screen.print(xopt1+130,360, ": "..strings.option_msg,1.02, color.gray)
		else
		    screen.print(char_fnt,xopt1-10,360, BTN_CROSS,1.02, color.gray) 
			screen.print(xopt1+10,360, ": "..strings.option1_msg,1.02, color.gray)
		    screen.print(char_fnt,xopt2-10,360, BTN_CIRCLE,1.02, color.gray) 
			screen.print(xopt2+10,360, ": "..strings.option2_msg,1.02, color.gray)
		end

		screen.flip()

		if buttons.released.cross and mode != 2 then-- Accept
			result = true
			break
		end

		if buttons.released.circle and mode != 0 then-- Cancel
			result = false
			break
		end
	end

	for i=102,0,-6 do

		if buff then buff:blit(0,0) end
		if box then
			box:scale(i)
			box:blit(960/2,544/2)
		end

		screen.flip()
	end

	if result then return true else return false end

end
--[[ 
	QuickLanch Installer
	
	Licensed by GNU General Public License v3.0
	
	(c) 2017 by lupus
	based on sources from Team OneLua
]]

game.close()
color.loadpalette()

-- Set path
local uxpath = "ux0:data/qlinstall/"
files.mkdir(uxpath)
local urpath = "ur0:shell/whats_new/np/"

-- Loading UI GFX
back = image.load("resources/back.jpg")
box = image.load("resources/box.png")
defapp01 = image.load ("resources/installer/app01.png")
defapp02 = image.load ("resources/installer/app02.png")
defapp03 = image.load ("resources/installer/app03.png")
userapp01 = image.load (uxpath.."app01.png")
userapp02 = image.load (uxpath.."app02.png")
userapp03 = image.load (uxpath.."app03.png")

-- Loading localisation data

-- Reading system language
__LANG = os.language()

-- Loading sa0 fonts for translations
charfont = "sa0:data/font/pvf/psexchar.pvf"
jpnfont = "sa0:data/font/pvf/jpn4.pvf"
ltnfont = "sa0:data/font/pvf/ltn4.pvf"
font.load(charfont)
font.load(jpnfont)
font.load(ltnfont)
if __LANG == "RUSSIAN" 
 or __LANG == "POLISH"
  then textfont=(ltnfont)
  else textfont=(jpnfont)
end
font.setdefault(textfont)

-- Loading Special chars
if charfont then
SYMBOL_CROSS	= "&"
SYMBOL_SQUARE   = "'"
SYMBOL_TRIANGLE = "$"
SYMBOL_CIRCLE	= "%"
else
SYMBOL_CROSS	= string.char(0xe2)..string.char(0x95)..string.char(0xb3)
SYMBOL_SQUARE	= string.char(0xe2)..string.char(0x96)..string.char(0xa1)
SYMBOL_TRIANGLE	= string.char(0xe2)..string.char(0x96)..string.char(0xb3)
SYMBOL_CIRCLE	= string.char(0xe2)..string.char(0x97)..string.char(0x8b)
end

-- reading lang strings from ux0:data/qlinstall/ if exist
if files.exists(uxpath.."lang/"..__LANG..".txt") then dofile(uxpath.."lang/"..__LANG..".txt")
else 
-- reading lang strings fom app folder if exist
	if files.exists("resources/lang/"..__LANG..".txt") then dofile("resources/lang/"..__LANG..".txt")
	local cont = 0
	for key,value in pairs(strings) do cont += 1 end
	if cont < 23 then files.copy("resources/lang/english_us.txt",uxpath.."lang/") dofile("resources/lang/english_us.txt") end
-- reading default lang strings if no one translations founded
else files.copy("resources/lang/english_us.txt",uxpath.."lang/") dofile("resources/lang/english_us.txt") end
end

if os.access() == 0 then
	if back2 then back2:blit(0,0) end 
	screen.flip()
	custom.message(strings.unsafe,0)
	os.exit()
end

--Auto-Update
dofile("git/updater.lua")

------------------------------------------Main--------------------------------------------------------------
-- Copy sample data to ux0:data/mmminstal
 if not files.exists(uxpath.."app01.png") then files.copy("resources/installer/app01.png",uxpath) end
 if not files.exists(uxpath.."app02.png") then files.copy("resources/installer/app02.png",uxpath) end
 if not files.exists(uxpath.."app03.png") then files.copy("resources/installer/app03.png",uxpath) end
 if not files.exists(uxpath.."whatsnew.xml") then files.copy("resources/installer/whatsnew.xml",uxpath) end
 if not files.exists(uxpath.."userapps.ini") then files.copy("resources/installer/userapps.ini",uxpath) end
 
 
-- Read userdata from .ini if exists
 if files.exists(uxpath.."userapps.ini") then dofile(uxpath.."userapps.ini") end
 
dofile("system/commons.lua")

options = { strings.menuline01, strings.menuline02, strings.menuline03, strings.menuline04}
sel = 1

buttons.interval(10,12)
while true do
	buttons.read()

	if back then back:blit(0,0) end
	draw.fillrect(0,0,960,30, 0x64545353) --UP
	--font.setdefault(charfont) screen.print(10,10,"$%&'`",1,color.white,color.blue,__ALEFT) font.setdefault(textfont)
	screen.print(10,10,strings.caption.."v"..APP_VERSION_MAJOR.."."..APP_VERSION_MINOR,1,color.white,color.blue,__ALEFT)
	screen.print(641,10,os.date("%r  %d/%m/%y"),1,color.white,color.blue,__ALEFT)


	local y = 45
	for i=1,#options do
		if i == sel then
			draw.fillrect(40,y-2,360,21, color.blue:a(150)) 
			draw.rect(40,y-2,360,21, color.green:a(100)) 
		end
		screen.print(49,y,options[i],1.0,color.white,color.gray,__ALEFT)
		y += 25
	end

	--Controls
	if buttons.up then sel-=1 end
	if buttons.down then sel+=1 end

	if sel > #options then sel=1 end
	if sel < 1 then sel=#options end
    if sel == 1 then modprev01() end
--	if sel == 2 then modprev02() end
	if buttons.cross then
		if sel == 1 then modinstall01()
		elseif sel == 2 then custom_msg(strings.future_msg,0)
			elseif sel == 3 then modreset()
				elseif sel == 4 then os.exit() buttons.homepopup(1)
		end
	end

	screen.flip()

end

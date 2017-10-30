--[[ 
	QuickLanch Installer
	
	Licensed by GNU General Public License v3.0
	
	(c) 2017 by lupus
	based on sources from Team OneLua
]]

-- Set path
local uxpath = "ux0:data/qlinstall/"
local urpath = "ur0:shell/whats_new/np/"

-- Install default QL data function
function modinstall01()
 buttons.homepopup(0)
 files.delete(urpath.."img")
 files.mkdir(urpath.."img/")
 files.delete(urpath.."whatsnew.xml")
 files.copy("resources/installer/app01.png",urpath.."img/")
 files.copy("resources/installer/app02.png",urpath.."img/")
 files.copy("resources/installer/app03.png",urpath.."img/")
 files.copy("resources/installer/whatsnew.xml",urpath)
 custom_msg(strings.qlinst01,0)
 os.delay(500)
 buttons.homepopup(1)
 power.restart()
 end

-- Install user mod data function
function modinstall02()
 buttons.homepopup(0)
 files.delete(urpath.."img")
 files.mkdir(urpath.."img/")
 files.delete(urpath.."whatsnew.xml")
 if files.exists(uxpath.."app01.png") then files.copy(uxpath.."app01.png",urpath.."img/") end
 if files.exists(uxpath.."app02.png") then files.copy(uxpath.."app02.png",urpath.."img/") end
 if files.exists(uxpath.."app03.png") then files.copy(uxpath.."app03.png",urpath.."img/") end
 if files.exists(uxpath.."whatsnew.xml") then files.copy(uxpath.."whatsnew.xml",urpath)  end
 custom_msg(strings.qlinst02,0)
 os.delay(500)
 buttons.homepopup(1)
 power.restart()
end

-- Reset mod data function
function modreset()
 files.delete(urpath.."img")
 files.mkdir(urpath.."img/")
 files.delete(urpath.."whatsnew.xml")
 custom_msg(strings.cleardata,0)
 os.delay(500)
 power.restart()
end

-- Preview default mod function
function modprev01()
 draw.fillrect(0,406,960,138, 0x64545353) --UP
 screen.print(10,416,strings.preview,1,color.white,color.blue,__ALEFT)
 if defapp01 then defapp01:blit(40,436) end 
 if defapp02 then defapp02:blit(339,436) end 
 if defapp03 then defapp03:blit(641,436) end 
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
        screen.print(10,10,strings.caption,1,color.white,color.blue,__ALEFT)
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
	screen.print(10,10,strings.caption,1,color.white,color.blue,__ALEFT)
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
			screen.print(xopt1+120,360, SYMBOL_CROSS.." : "..strings.option_msg,1.02, color.gray)
		else
			screen.print(xopt1,360, SYMBOL_CROSS.." : "..strings.option1_msg,1.02, color.gray)
			screen.print(xopt2,360, SYMBOL_CIRCLE.." : "..strings.option2_msg,1.02, color.gray)
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
script_version("1.0")
script_name("FSUNIVERSAL")
script_author("Jetler")
script_description("Script crack by Jetler")

require "lib.moonloader" -- ïîäêëþ÷åíèå áèáëèîòåê

local inicfg = require "inicfg" -- ïîäêëþ÷åíèå áèáëèîòåêè inicfg
local dlstatus = require('moonloader').download_status
local sampev = require 'lib.samp.events'
local keys = require 'vkeys'
local encoding = require "encoding" -- ïîäêëþ÷åíèå ðóñèôèêàêöèè (ðóññêîãî òåêñòà)

local directIni = "moonloader\\fsuniversal.ini"

update_state = false

local script_vers = 2
local script_vers_text = "2.00"

local update_url = "https://raw.githubusercontent.com/Jetler/fsuniversal/master/update.ini" -- òóò òîæå ñâîþ ññûëêó
local update_path = getWorkingDirectory() .. "/update.ini" -- è òóò ñâîþ ññûëêó

-- local script_url ""

local script_url = "https://github.com/Jetler/fsuniversal/blob/master/fsuniversal.lua" -- òóò ñâîþ ññûëêó
local script_path = thisScript().path

local mainIni = inicfg.load(nil, directIni)
encoding.default = "CP1251" -- Ïîäêëþ÷åíèå êîäèðîâêè CP1251
u8 = encoding.UTF8 -- ïåðåìåííàÿ äëÿ òðàíñëèòà òåêñòà íà ðóññêèé ÿçûê


function main()

	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end
	
    
	sampRegisterChatCommand("fsuniversal", fsuniversal)
	sampRegisterChatCommand("update", check_update)

	_, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
    nick = sampGetPlayerNickname(id)

    downloadUrlToFile(update_url, update_path, function(id, status)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            updateIni = inicfg.load(nil, update_path)
			if tonumber(updateIni.info.vers) > script_vers then
				dlg = string.format("{AE433D}* {AFAFAF}Âàæíàÿ èíôîðìàöèÿ! Âåðñèÿ âàøåãî ñêðèïòà óñòàðåëà\n{AE433D}* {AFAFAF}Äëÿ ñòàáèëüíîé èãðû îáíîâèòå ñêðèïò Êíîïêîé {AE433D}'Îáíîâèòü' {AFAFAF}èëè êîìàíäîé {AE433D}/update\n{AE433D}* {AFAFAF}Òåêóùàÿ âåðñèÿ ñêðïèòà: {AE433D}" ..thisScript().version.. "v \n{AE433D}* {AFAFAF}Îáíîâëåíàÿ âåðñèÿ ñêðèïòà: {AE433D}"..updateIni.info.vers_text..".0v")
				sampShowDialog(3, "{AFAFAF}FSUNIVERSAL | {AE433D}Àâòîîáíîâëåíèå", dlg, "Îáíîâèòü", "Çàâåðøèòü")
				sampAddChatMessage(string.format("[FSUNIVERSAL] {AFAFAF}Äëÿ îáíîâëåíèÿ ââåäèòå êîìàíäó {AE433D}/update", thisScript().version), 0xAE433D) -- âûâîäèì òåêñòà â ÷àò
				update_state = true
			else 
				dialog = (string.format("{AE433D}* {AFAFAF}Âàæíàÿ èíôîðìàöèÿ! Íîâûõ îáíîâëåíèé íå îáíàðóæåíî!\n{AE433D}* {AFAFAF}Ðàáîòà ñêðèïòà ïðîäîëæåíà.\n{AE433D}* {AFAFAF}Òåêóùàÿ âåðñèÿ ñêðèïòà: {ae433d}" ..thisScript().version) .."v")
				sampShowDialog(2, "{AFAFAF}FSUNIVERSAL | {AE433D}Àâòîîáíîâëåíèå", dialog, "Îêåé", "")
				sampAddChatMessage(string.format("[FSUNIVERSAL] {AFAFAF}Ñêðèïò óñïåøíî çàãðóæåí! Òåêóùàÿ âåðñèÿ ñêðèïòà {AE433D}%sv. {AFAFAF}Ðàçðàáîò÷èê ñêðèïòà {AE433D}Jetler", thisScript().version), 0xAE433D) -- âûâîäèì òåêñòà â ÷àò
				sampAddChatMessage(string.format("[FSUNIVERSAL] {AFAFAF}Ïîìîùü ïî èñïîëüçîâàíèþ: {AE433D}/fsuniversal", thisScript().version), 0xAE433D) -- âûâîäèì òåêñòà â ÷àò
            end
            os.remove(update_path)
        end
	end)

	while true do
		wait(0)
	local result, button, _, input = sampHasDialogRespond(3)

	if result then
		if button == 1 then
			if update_state then
				downloadUrlToFile(script_url, script_path, function(id, status)
					if status == dlstatus.STATUS_ENDDOWNLOADDATA then
						sampAddChatMessage("Ñêðèïò óñïåøíî îáíîâëåí!", -1)
						thisScript():reload()
					end
				end)
				break
			end
			else
				sampAddChatMessage("íå óñïåøíî îáíîâëåí!", -1)
			end
		end
end
	
end

function sampev.onShowDialog(dialogid, style, title, button1, button2, text)
	--sampAddChatMessage(string.format("ShowPlayerDialog(playerid, %d, %s, %s, %s, %s, %s", dialogid, style, button1, button2, text), 0xAFAFAF)
	-- sampAddChatMessage(string.format("ShowPlayerDialog(playerid, %d, %s, %s, %s, %s, %s", dialogid, style, button1, button2, text), 0xAE433D) -- âûâîäèì òåêñòà â ÷àò
	--sampAddChatMessage(dialogid style, title, button1, button2, text)
	sampAddChatMessage(string.format("ShowPlayerDialog(playerid," ..dialogid.. ","..style.. ","..title..","..text..","..button1..","..button2), 0xAFAFAF)
end

function fsuniversal()
	if update_state == true then
		sampAddChatMessage("[FSUNIVERSAL] {AFAFAF}Âû åùå íå îáíîâèëè ñêðèïò, ïîñëå îáíîâëåíèÿ, ñêðèïò âîçîáíîâèò ñâîþ ðàáîòó!", 0xae433d)
	end
	if update_state == false then
		sampShowDialog(2, "{AFAFAF}FSUNIVERSAL | {AE433D}Èíñòðóêöèÿ", "{AFAFAF}Êëàâèøà Z: Îòêðûòü ìåíþ FS3DT [{ae433d}3D Text Stealer{AFAFAF}]\n{AFAFAF}Êëàâèøà X: Îòêðûòü ìåíþ FSD [{ae433d}Dialog Stealer{AFAFAF}]\n{AFAFAF}Êëàâèøà B: Îòêðûòü ìåíþ FSSPAO [{ae433d}PlayerAttach Strealer{AFAFAF}]\n{AFAFAF}Êëàâèøà M: Îòêðûòü ìåíþ FSPICKUP [{ae433d}Pickup Strealer{AFAFAF}]\n{AFAFAF}Êëàâèøà K: Îòêðûòü ìåíþ FSMAPICON [{ae433d}MapIcon Strealer{AFAFAF}]\n{AFAFAF}Êëàâèøà J: Îòêðûòü ìåíþ FSACTOR [{ae433d}Actor Strealer{AFAFAF}]\n{AFAFAF}Êëàâèøà L: Îòêðûòü ìåíþ FS3DT + FSPICKUP (BETA) [{ae433d}3D Text + Pickup Stealer{AFAFAF}]\n{AFAFAF}Êîìàíäà /fsoav [{ae433d}VehicleAttach Stealer{AFAFAF}]\n{AFAFAF}Êîìàíäà /fso [{ae433d}Object Stealer{AFAFAF}]\n{AFAFAF}Êîìàíäà /fstd [{ae433d}TextDraw Stealer{AFAFAF}]\n{AFAFAF}Êîìàíäà /fscam [{ae433d}Camera Stealer{AFAFAF}]\n{AFAFAF}Êîìàíäà /fsanim [{ae433d}Anim Stealer{AFAFAF}]\n{AFAFAF}Êîìàíäà /fsgametext [{ae433d}GameText Stealer{AFAFAF}]\n{AFAFAF}Êîìàíäà /fssound [{ae433d}Sounds Stealer{AFAFAF}]\n{afafaf}Êîìàíäà /update [{AE433D}Ïðîâåðêà íà îáíîâëåíèÿ{AFAFAF}]\n\nÀâòîð äîðàáîòêè ñêðèïòà - {AE433D}Jetler", "Çàêðûòü", "")
	end
end

function check_update()
	
    downloadUrlToFile(update_url, update_path, function(id, status)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            updateIni = inicfg.load(nil, update_path)
			if tonumber(updateIni.info.vers) > script_vers then
				dlg = string.format("{AE433D}* {AFAFAF}Âàæíàÿ èíôîðìàöèÿ! Âåðñèÿ âàøåãî ñêðèïòà óñòàðåëà\n{AE433D}* {AFAFAF}Äëÿ ñòàáèëüíîé èãðû îáíîâèòå ñêðèïò Êíîïêîé {AE433D}'Îáíîâèòü' {AFAFAF}èëè êîìàíäîé {AE433D}/update\n{AE433D}* {AFAFAF}Òåêóùàÿ âåðñèÿ ñêðïèòà: {AE433D}" ..thisScript().version.. "v \n{AE433D}* {AFAFAF}Îáíîâëåíàÿ âåðñèÿ ñêðèïòà: {AE433D}"..updateIni.info.vers_text..".0v")
				sampShowDialog(3, "{AFAFAF}FSUNIVERSAL | {AE433D}Àâòîîáíîâëåíèå", dlg, "Îáíîâèòü", "Çàâåðøèòü")
				sampAddChatMessage(string.format("[FSUNIVERSAL] {AFAFAF}Äëÿ îáíîâëåíèÿ ââåäèòå êîìàíäó {AE433D}/update", thisScript().version), 0xAE433D) -- âûâîäèì òåêñòà â ÷àò
				update_state = true
			else 
				dialog = (string.format("{AE433D}* {AFAFAF}Âàæíàÿ èíôîðìàöèÿ! Íîâûõ îáíîâëåíèé íå îáíàðóæåíî!\n{AE433D}* {AFAFAF}Ðàáîòà ñêðèïòà ïðîäîëæåíà.\n{AE433D}* {AFAFAF}Òåêóùàÿ âåðñèÿ ñêðèïòà: {ae433d}" ..thisScript().version) .."v")
				sampShowDialog(2, "{AFAFAF}FSUNIVERSAL | {AE433D}Àâòîîáíîâëåíèå", dialog, "Îêåé", "")
				sampAddChatMessage(string.format("[FSUNIVERSAL] {AFAFAF}Ñêðèïò óñïåøíî çàãðóæåí! Òåêóùàÿ âåðñèÿ ñêðèïòà {AE433D}%sv. {AFAFAF}Ðàçðàáîò÷èê ñêðèïòà {AE433D}Jetler", thisScript().version), 0xAE433D) -- âûâîäèì òåêñòà â ÷àò
				sampAddChatMessage(string.format("[FSUNIVERSAL] {AFAFAF}Ïîìîùü ïî èñïîëüçîâàíèþ: {AE433D}/fsuniversal", thisScript().version), 0xAE433D) -- âûâîäèì òåêñòà â ÷àò
            end
            os.remove(update_path)
        end
    end)
end

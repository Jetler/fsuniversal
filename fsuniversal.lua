script_version("1.0")
script_name("FSUNIVERSAL")
script_author("Jetler")
script_description("Script crack by Jetler")

require "lib.moonloader" -- ����������� ���������

local inicfg = require "inicfg" -- ����������� ���������� inicfg
local dlstatus = require('moonloader').download_status
local sampev = require 'lib.samp.events'
local keys = require 'vkeys'
local encoding = require "encoding" -- ����������� ������������ (�������� ������)

local directIni = "moonloader\\fsuniversal.ini"

update_state = false

local script_vers = 2
local script_vers_text = "2.00"

local update_url = "https://raw.githubusercontent.com/Jetler/fsuniversal/master/update.ini" -- ��� ���� ���� ������
local update_path = getWorkingDirectory() .. "/update.ini" -- � ��� ���� ������

-- local script_url ""

local script_url = "https://raw.githubusercontent.com/Jetler/fsuniversal/master/update.ini" -- ��� ���� ������
local script_path = thisScript().path

local mainIni = inicfg.load(nil, directIni)
encoding.default = "CP1251" -- ����������� ��������� CP1251
u8 = encoding.UTF8 -- ���������� ��� ��������� ������ �� ������� ����


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
				dlg = string.format("{AE433D}* {AFAFAF}������ ����������! ������ ������ ������� ��������\n{AE433D}* {AFAFAF}��� ���������� ���� �������� ������ ������� {AE433D}'��������' {AFAFAF}��� �������� {AE433D}/update\n{AE433D}* {AFAFAF}������� ������ �������: {AE433D}" ..thisScript().version.. "v \n{AE433D}* {AFAFAF}���������� ������ �������: {AE433D}"..updateIni.info.vers_text..".0v")
				sampShowDialog(3, "{AFAFAF}FSUNIVERSAL | {AE433D}��������������", dlg, "��������", "���������")
				sampAddChatMessage(string.format("[FSUNIVERSAL] {AFAFAF}��� ���������� ������� ������� {AE433D}/update", thisScript().version), 0xAE433D) -- ������� ������ � ���
				update_state = true
			else 
				dialog = (string.format("{AE433D}* {AFAFAF}������ ����������! ����� ���������� �� ����������!\n{AE433D}* {AFAFAF}������ ������� ����������.\n{AE433D}* {AFAFAF}������� ������ �������: {ae433d}" ..thisScript().version) .."v")
				sampShowDialog(2, "{AFAFAF}FSUNIVERSAL | {AE433D}��������������", dialog, "����", "")
				sampAddChatMessage(string.format("[FSUNIVERSAL] {AFAFAF}������ ������� ��������! ������� ������ ������� {AE433D}%sv. {AFAFAF}����������� ������� {AE433D}Jetler", thisScript().version), 0xAE433D) -- ������� ������ � ���
				sampAddChatMessage(string.format("[FSUNIVERSAL] {AFAFAF}������ �� �������������: {AE433D}/fsuniversal", thisScript().version), 0xAE433D) -- ������� ������ � ���
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
						sampAddChatMessage("������ ������� ��������!", -1)
						thisScript():reload()
					end
				end)
				break
			end
			else
				sampAddChatMessage("�� ������� ��������!", -1)
			end
		end
end
	
end

function sampev.onShowDialog(dialogid, style, title, button1, button2, text)
	--sampAddChatMessage(string.format("ShowPlayerDialog(playerid, %d, %s, %s, %s, %s, %s", dialogid, style, button1, button2, text), 0xAFAFAF)
	-- sampAddChatMessage(string.format("ShowPlayerDialog(playerid, %d, %s, %s, %s, %s, %s", dialogid, style, button1, button2, text), 0xAE433D) -- ������� ������ � ���
	--sampAddChatMessage(dialogid style, title, button1, button2, text)
	sampAddChatMessage(string.format("ShowPlayerDialog(playerid," ..dialogid.. ","..style.. ","..title..","..text..","..button1..","..button2), 0xAFAFAF)
end

function fsuniversal()
	if update_state == true then
		sampAddChatMessage("[FSUNIVERSAL] {AFAFAF}�� ��� �� �������� ������, ����� ����������, ������ ���������� ���� ������!", 0xae433d)
	end
	if update_state == false then
		sampShowDialog(2, "{AFAFAF}FSUNIVERSAL | {AE433D}����������", "{AFAFAF}������� Z: ������� ���� FS3DT [{ae433d}3D Text Stealer{AFAFAF}]\n{AFAFAF}������� X: ������� ���� FSD [{ae433d}Dialog Stealer{AFAFAF}]\n{AFAFAF}������� B: ������� ���� FSSPAO [{ae433d}PlayerAttach Strealer{AFAFAF}]\n{AFAFAF}������� M: ������� ���� FSPICKUP [{ae433d}Pickup Strealer{AFAFAF}]\n{AFAFAF}������� K: ������� ���� FSMAPICON [{ae433d}MapIcon Strealer{AFAFAF}]\n{AFAFAF}������� J: ������� ���� FSACTOR [{ae433d}Actor Strealer{AFAFAF}]\n{AFAFAF}������� L: ������� ���� FS3DT + FSPICKUP (BETA) [{ae433d}3D Text + Pickup Stealer{AFAFAF}]\n{AFAFAF}������� /fsoav [{ae433d}VehicleAttach Stealer{AFAFAF}]\n{AFAFAF}������� /fso [{ae433d}Object Stealer{AFAFAF}]\n{AFAFAF}������� /fstd [{ae433d}TextDraw Stealer{AFAFAF}]\n{AFAFAF}������� /fscam [{ae433d}Camera Stealer{AFAFAF}]\n{AFAFAF}������� /fsanim [{ae433d}Anim Stealer{AFAFAF}]\n{AFAFAF}������� /fsgametext [{ae433d}GameText Stealer{AFAFAF}]\n{AFAFAF}������� /fssound [{ae433d}Sounds Stealer{AFAFAF}]\n{afafaf}������� /update [{AE433D}�������� �� ����������{AFAFAF}]\n\n����� ��������� ������� - {AE433D}Jetler", "�������", "")
	end
end

function check_update()
	
    downloadUrlToFile(update_url, update_path, function(id, status)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            updateIni = inicfg.load(nil, update_path)
			if tonumber(updateIni.info.vers) > script_vers then
				dlg = string.format("{AE433D}* {AFAFAF}������ ����������! ������ ������ ������� ��������\n{AE433D}* {AFAFAF}��� ���������� ���� �������� ������ ������� {AE433D}'��������' {AFAFAF}��� �������� {AE433D}/update\n{AE433D}* {AFAFAF}������� ������ �������: {AE433D}" ..thisScript().version.. "v \n{AE433D}* {AFAFAF}���������� ������ �������: {AE433D}"..updateIni.info.vers_text..".0v")
				sampShowDialog(3, "{AFAFAF}FSUNIVERSAL | {AE433D}��������������", dlg, "��������", "���������")
				sampAddChatMessage(string.format("[FSUNIVERSAL] {AFAFAF}��� ���������� ������� ������� {AE433D}/update", thisScript().version), 0xAE433D) -- ������� ������ � ���
				update_state = true
			else 
				dialog = (string.format("{AE433D}* {AFAFAF}������ ����������! ����� ���������� �� ����������!\n{AE433D}* {AFAFAF}������ ������� ����������.\n{AE433D}* {AFAFAF}������� ������ �������: {ae433d}" ..thisScript().version) .."v")
				sampShowDialog(2, "{AFAFAF}FSUNIVERSAL | {AE433D}��������������", dialog, "����", "")
				sampAddChatMessage(string.format("[FSUNIVERSAL] {AFAFAF}������ ������� ��������! ������� ������ ������� {AE433D}%sv. {AFAFAF}����������� ������� {AE433D}Jetler", thisScript().version), 0xAE433D) -- ������� ������ � ���
				sampAddChatMessage(string.format("[FSUNIVERSAL] {AFAFAF}������ �� �������������: {AE433D}/fsuniversal", thisScript().version), 0xAE433D) -- ������� ������ � ���
            end
            os.remove(update_path)
        end
    end)
end
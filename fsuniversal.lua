script_version("1.0")
script_name("FSUNIVERSAL")
script_author("Jetler")
script_description("Script crack by Jetler")

require "lib.moonloader" -- подключение библиотек

local inicfg = require "inicfg" -- подключение библиотеки inicfg
local dlstatus = require('moonloader').download_status
local sampev = require 'lib.samp.events'
local keys = require 'vkeys'
local encoding = require "encoding" -- подключение русификакции (русского текста)

local directIni = "moonloader\\fsuniversal.ini"

update_state = false

local script_vers = 2
local script_vers_text = "2.00"

local update_url = "https://raw.githubusercontent.com/Jetler/fsuniversal/master/update.ini" -- тут тоже свою ссылку
local update_path = getWorkingDirectory() .. "/update.ini" -- и тут свою ссылку

-- local script_url ""

local script_url = "https://raw.githubusercontent.com/Jetler/fsuniversal/master/update.ini" -- тут свою ссылку
local script_path = thisScript().path

local mainIni = inicfg.load(nil, directIni)
encoding.default = "CP1251" -- Подключение кодировки CP1251
u8 = encoding.UTF8 -- переменная для транслита текста на русский язык


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
				dlg = string.format("{AE433D}* {AFAFAF}Важная информация! Версия вашего скрипта устарела\n{AE433D}* {AFAFAF}Для стабильной игры обновите скрипт Кнопкой {AE433D}'Обновить' {AFAFAF}или командой {AE433D}/update\n{AE433D}* {AFAFAF}Текущая версия скрпита: {AE433D}" ..thisScript().version.. "v \n{AE433D}* {AFAFAF}Обновленая версия скрипта: {AE433D}"..updateIni.info.vers_text..".0v")
				sampShowDialog(3, "{AFAFAF}FSUNIVERSAL | {AE433D}Автообновление", dlg, "Обновить", "Завершить")
				sampAddChatMessage(string.format("[FSUNIVERSAL] {AFAFAF}Для обновления введите команду {AE433D}/update", thisScript().version), 0xAE433D) -- выводим текста в чат
				update_state = true
			else 
				dialog = (string.format("{AE433D}* {AFAFAF}Важная информация! Новых обновлений не обнаружено!\n{AE433D}* {AFAFAF}Работа скрипта продолжена.\n{AE433D}* {AFAFAF}Текущая версия скрипта: {ae433d}" ..thisScript().version) .."v")
				sampShowDialog(2, "{AFAFAF}FSUNIVERSAL | {AE433D}Автообновление", dialog, "Окей", "")
				sampAddChatMessage(string.format("[FSUNIVERSAL] {AFAFAF}Скрипт успешно загружен! Текущая версия скрипта {AE433D}%sv. {AFAFAF}Разработчик скрипта {AE433D}Jetler", thisScript().version), 0xAE433D) -- выводим текста в чат
				sampAddChatMessage(string.format("[FSUNIVERSAL] {AFAFAF}Помощь по использованию: {AE433D}/fsuniversal", thisScript().version), 0xAE433D) -- выводим текста в чат
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
						sampAddChatMessage("Скрипт успешно обновлен!", -1)
						thisScript():reload()
					end
				end)
				break
			end
			else
				sampAddChatMessage("не успешно обновлен!", -1)
			end
		end
end
	
end

function sampev.onShowDialog(dialogid, style, title, button1, button2, text)
	--sampAddChatMessage(string.format("ShowPlayerDialog(playerid, %d, %s, %s, %s, %s, %s", dialogid, style, button1, button2, text), 0xAFAFAF)
	-- sampAddChatMessage(string.format("ShowPlayerDialog(playerid, %d, %s, %s, %s, %s, %s", dialogid, style, button1, button2, text), 0xAE433D) -- выводим текста в чат
	--sampAddChatMessage(dialogid style, title, button1, button2, text)
	sampAddChatMessage(string.format("ShowPlayerDialog(playerid," ..dialogid.. ","..style.. ","..title..","..text..","..button1..","..button2), 0xAFAFAF)
end

function fsuniversal()
	if update_state == true then
		sampAddChatMessage("[FSUNIVERSAL] {AFAFAF}Вы еще не обновили скрипт, после обновления, скрипт возобновит свою работу!", 0xae433d)
	end
	if update_state == false then
		sampShowDialog(2, "{AFAFAF}FSUNIVERSAL | {AE433D}Инструкция", "{AFAFAF}Клавиша Z: Открыть меню FS3DT [{ae433d}3D Text Stealer{AFAFAF}]\n{AFAFAF}Клавиша X: Открыть меню FSD [{ae433d}Dialog Stealer{AFAFAF}]\n{AFAFAF}Клавиша B: Открыть меню FSSPAO [{ae433d}PlayerAttach Strealer{AFAFAF}]\n{AFAFAF}Клавиша M: Открыть меню FSPICKUP [{ae433d}Pickup Strealer{AFAFAF}]\n{AFAFAF}Клавиша K: Открыть меню FSMAPICON [{ae433d}MapIcon Strealer{AFAFAF}]\n{AFAFAF}Клавиша J: Открыть меню FSACTOR [{ae433d}Actor Strealer{AFAFAF}]\n{AFAFAF}Клавиша L: Открыть меню FS3DT + FSPICKUP (BETA) [{ae433d}3D Text + Pickup Stealer{AFAFAF}]\n{AFAFAF}Команда /fsoav [{ae433d}VehicleAttach Stealer{AFAFAF}]\n{AFAFAF}Команда /fso [{ae433d}Object Stealer{AFAFAF}]\n{AFAFAF}Команда /fstd [{ae433d}TextDraw Stealer{AFAFAF}]\n{AFAFAF}Команда /fscam [{ae433d}Camera Stealer{AFAFAF}]\n{AFAFAF}Команда /fsanim [{ae433d}Anim Stealer{AFAFAF}]\n{AFAFAF}Команда /fsgametext [{ae433d}GameText Stealer{AFAFAF}]\n{AFAFAF}Команда /fssound [{ae433d}Sounds Stealer{AFAFAF}]\n{afafaf}Команда /update [{AE433D}Проверка на обновления{AFAFAF}]\n\nАвтор доработки скрипта - {AE433D}Jetler", "Закрыть", "")
	end
end

function check_update()
	
    downloadUrlToFile(update_url, update_path, function(id, status)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            updateIni = inicfg.load(nil, update_path)
			if tonumber(updateIni.info.vers) > script_vers then
				dlg = string.format("{AE433D}* {AFAFAF}Важная информация! Версия вашего скрипта устарела\n{AE433D}* {AFAFAF}Для стабильной игры обновите скрипт Кнопкой {AE433D}'Обновить' {AFAFAF}или командой {AE433D}/update\n{AE433D}* {AFAFAF}Текущая версия скрпита: {AE433D}" ..thisScript().version.. "v \n{AE433D}* {AFAFAF}Обновленая версия скрипта: {AE433D}"..updateIni.info.vers_text..".0v")
				sampShowDialog(3, "{AFAFAF}FSUNIVERSAL | {AE433D}Автообновление", dlg, "Обновить", "Завершить")
				sampAddChatMessage(string.format("[FSUNIVERSAL] {AFAFAF}Для обновления введите команду {AE433D}/update", thisScript().version), 0xAE433D) -- выводим текста в чат
				update_state = true
			else 
				dialog = (string.format("{AE433D}* {AFAFAF}Важная информация! Новых обновлений не обнаружено!\n{AE433D}* {AFAFAF}Работа скрипта продолжена.\n{AE433D}* {AFAFAF}Текущая версия скрипта: {ae433d}" ..thisScript().version) .."v")
				sampShowDialog(2, "{AFAFAF}FSUNIVERSAL | {AE433D}Автообновление", dialog, "Окей", "")
				sampAddChatMessage(string.format("[FSUNIVERSAL] {AFAFAF}Скрипт успешно загружен! Текущая версия скрипта {AE433D}%sv. {AFAFAF}Разработчик скрипта {AE433D}Jetler", thisScript().version), 0xAE433D) -- выводим текста в чат
				sampAddChatMessage(string.format("[FSUNIVERSAL] {AFAFAF}Помощь по использованию: {AE433D}/fsuniversal", thisScript().version), 0xAE433D) -- выводим текста в чат
            end
            os.remove(update_path)
        end
    end)
end
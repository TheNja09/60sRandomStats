rngWait = 3600
rngBaseSpeed = 8
rngValor = 12
rngWisdom = 12
rngMaster = 10
rngFinal = 16
rngAnti = 16
rngLion = 18
rngMermaid = 7
rngCarpet = 20
rngDice = 8
rngCard = 8
rngLimit = 8
rngAttack = 10
rngMagic = 10
rngDefense = 10
rngHP = 20
rngMP = 100
function _OnFrame()
	World = ReadByte(Now + 0x00)
	Room = ReadByte(Now + 0x01)
	Place = ReadShort(Now + 0x00)
	Door = ReadShort(Now + 0x02)
	Map = ReadShort(Now + 0x04)
	Btl = ReadShort(Now + 0x06)
	Evt = ReadShort(Now + 0x08)
	Cheats()
end

function _OnInit()
	if GAME_ID == 0xF266B00B or GAME_ID == 0xFAF99301 and ENGINE_TYPE == "ENGINE" then--PCSX2
		Platform = 'PS2'
		Now = 0x032BAE0 --Current Location
		Save = 0x032BB30 --Save File
		Obj0 = 0x1C94100 --00objentry.bin
		Sys3 = 0x1CCB300 --03system.bin
		Btl0 = 0x1CE5D80 --00battle.bin
		Slot1 = 0x1C6C750 --Unit Slot 1
	elseif GAME_ID == 0x431219CC and ENGINE_TYPE == 'BACKEND' then--PC
		Platform = 'PC'
		Now = 0x0714DB8 - 0x56454E
		Save = 0x09A7070 - 0x56450E
		Obj0 = 0x2A22B90 - 0x56450E
		Sys3 = 0x2A59DB0 - 0x56450E
		Btl0 = 0x2A74840 - 0x56450E
		Slot1 = 0x2A20C58 - 0x56450E
	end
end

function Events(M,B,E) --Check for Map, Btl, and Evt
	return ((Map == M or not M) and (Btl == B or not B) and (Evt == E or not E))
end

function Cheats()
rngWait = rngWait - 1
	if ReadByte(Slot1+0x0) > ReadByte(Slot1+0x4) then
	WriteByte(Slot1+0x0, ReadByte(Slot1+0x4))
	end
	if ReadByte(Slot1+0x180) > ReadByte(Slot1+0x184) then
	WriteByte(Slot1+0x180, ReadByte(Slot1+0x184))
	end
	if rngWait == 0 then
	rngBaseSpeed = math.random(1,40)
	rngValor = math.random(1,60)
	rngWisdom = math.random(1,60)
	rngMaster = math.random(1,50)
	rngFinal = math.random(1,80)
	rngAnti = math.random(1,80)
	rngLion = math.random(1,90)
	rngMermaid = math.random(1,35)
	rngCarpet = math.random(1,100)
	rngDice = math.random(1,40)
	rngCard = math.random(1,40)
	rngLimit = math.random(1,40)
	rngAttack = math.random(1,80)
	rngMagic = math.random(1,80)
	rngDefense = math.random(1,80)
	rngHP = math.random(1,120)
	rngMP = math.random(1,140)
	end
WriteFloat(Sys3+0x17CE4, rngBaseSpeed) -- Base Speed: DS = 8
WriteFloat(Sys3+0x17D18, rngValor) -- Valor Form: DS = 12
WriteFloat(Sys3+0x17D4C, rngWisdom) -- Wisdom Form: DS = 12
WriteFloat(Sys3+0x17D80, rngMaster) -- Master Form: DS = 10
WriteFloat(Sys3+0x17DB4, rngFinal) -- Final Form: DS = 16
WriteFloat(Sys3+0x17E1C, rngLion) -- Lion Sora: DS = 18
WriteFloat(Sys3+0x17DE8, rngAnti) -- Anti Form: DS = 16
WriteFloat(Sys3+0x17E50, rngMermaid) -- Mermaid Sora: DS = 7
WriteFloat(Sys3+0x18190, rngCarpet) -- Carpet Sora: DS = 20
WriteFloat(Sys3+0x181F8, rngDice) -- Dice Sora: DS = 8
WriteFloat(Sys3+0x1822C, rngCard) -- Card Sora: DS = 8
WriteFloat(Sys3+0x18364, rngLimit) -- Limit Form: DS = 8
WriteByte(Slot1+0x4, rngHP)
WriteByte(Slot1+0x184, rngMP)
WriteByte(0x24BC8D2, rngAttack)
WriteByte(0x24BC8D4, rngMagic)
WriteByte(0x24BC8D6, rngDefense)
	if rngWait == 0 then
	ConsolePrint("New Attack:")
	ConsolePrint(ReadByte(0x24BC8D2))
	ConsolePrint("New Magic:")
	ConsolePrint(ReadByte(0x24BC8D4))
	ConsolePrint("New Defense:")
	ConsolePrint(ReadByte(0x24BC8D6))
	ConsolePrint("New HP:")
	ConsolePrint(ReadByte(Slot1+0x4))
	ConsolePrint("New MP:")
	ConsolePrint(ReadByte(Slot1+0x184))
	ConsolePrint("New Base Speed:")
	ConsolePrint(ReadFloat(Sys3+0x17CE4))
	end
	if rngWait == 180 then
	ConsolePrint("Next random set of stats in 3 seconds!")
	elseif rngWait == 120 then
	ConsolePrint("Next random set of stats in 2 seconds!")
	elseif rngWait == 60 then
	ConsolePrint("Next random set of stats in 1 second!")
	elseif rngWait == 0 then
	rngWait = 3600
	end
end

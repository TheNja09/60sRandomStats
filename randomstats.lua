rngWait = 3600
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
if ReadByte(Slot1+0x0) > ReadByte(Slot1+0x4) then
	WriteByte(Slot1+0x0, ReadByte(Slot1+0x4))
end
if ReadByte(Slot1+0x180) > ReadByte(Slot1+0x184) then
	WriteByte(Slot1+0x180, ReadByte(Slot1+0x184))
end
math.randomseed(os.time())
rngWait = rngWait - 1
if rngWait == 180 then
	ConsolePrint("Next random set of stats in 3 seconds!")
end
if rngWait == 120 then
	ConsolePrint("Next random set of stats in 2 seconds!")
end
if rngWait == 60 then
	ConsolePrint("Next random set of stats in 1 seconds!")
end
if rngWait <= 0 then
	WriteFloat(Sys3+0x17CE4, math.random(1,24)) -- Base Speed: DS = 8
	WriteFloat(Sys3+0x17D18, math.random(1,36)) -- Valor Form: DS = 12
	WriteFloat(Sys3+0x17D4C, math.random(1,36)) -- Wisdom Form: DS = 12
	WriteFloat(Sys3+0x17D80, math.random(1,30)) -- Master Form: DS = 10
	WriteFloat(Sys3+0x17DB4, math.random(1,48)) -- Final Form: DS = 16
	WriteFloat(Sys3+0x17E1C, math.random(1,54)) -- Lion Sora: DS = 18
	WriteFloat(Sys3+0x17DE8, math.random(1,48)) -- Anti Form: DS = 16
	WriteFloat(Sys3+0x17E50, math.random(1,21)) -- Mermaid Sora: DS = 7
	WriteFloat(Sys3+0x18190, math.random(1,60)) -- Carpet Sora: DS = 20
	WriteFloat(Sys3+0x181F8, math.random(1,24)) -- Dice Sora: DS = 8
	WriteFloat(Sys3+0x1822C, math.random(1,24)) -- Card Sora: DS = 8
	WriteFloat(Sys3+0x18364, math.random(1,24)) -- Limit Form: DS = 8
	WriteByte(Slot1+0x4, math.random(1,200))
	WriteByte(Slot1+0x184, math.random(1,200))
	WriteByte(0x2535C5E, math.random(1,200))
	WriteByte(0x2535C5F, math.random(1,200))
	WriteByte(0x2535C60, math.random(1,200))
	rngWait = 3600
	ConsolePrint("Current Attack:")
	ConsolePrint(ReadByte(0x2535C5E))
	ConsolePrint("Current Magic:")
	ConsolePrint(ReadByte(0x2535C5F))
	ConsolePrint("Current Defense:")
	ConsolePrint(ReadByte(0x2535C60))
	ConsolePrint("Max HP:")
	ConsolePrint(ReadByte(Slot1+0x4))
	ConsolePrint("Max MP:")
	ConsolePrint(ReadByte(Slot1+0x184))
end
end

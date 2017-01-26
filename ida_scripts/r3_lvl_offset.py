# This script adds a function - memToLvl - which allows you to convert memory addresses to file addresses for LVL files.
# You need to have my IDA database for this script to work.

import idc

idc.Message("Initializing Rayman 3 extension for IDA!\n")

def memToLvl(address, levelId = None):
    refTableAddr = idc.LocByName("levelReferenceTable")
    if refTableAddr == BADADDR:
        print("Can't get level reference table address. Make sure its name is levelReferenceTable.")
        return
    
    if levelId == None:
        endTableAddr = idc.LocByName("levelEndTable")
        if endTableAddr == BADADDR:
            print("Can't get level end table address. Make sure its name is levelEndTable.")
            return

        lvl0StartAddr = idc.Dword(refTableAddr)
        lvl1StartAddr = idc.Dword(refTableAddr + 4)

        lvl0EndAddr = idc.Dword(endTableAddr) 
        lvl1EndAddr = idc.Dword(endTableAddr + 4)

        if address >= lvl0StartAddr and address <= lvl0EndAddr:
            fileRelativeAddr = address - lvl0StartAddr 
            idc.Message("Fix.lvl relative address: 0x" + format(fileRelativeAddr, '02X') + "\n")
            return

        if address >= lvl1StartAddr and address <= lvl1EndAddr:
            fileRelativeAddr = address - lvl1StartAddr 
            idc.Message("Actual level relative address: 0x" + format(fileRelativeAddr, '02X') + "\n")
            return

        idc.Message("ERROR: This address does not belong to any level file.")
    else:
        lvlStartAddr = idc.Dword(refTableAddr + levelId * 4)
        fileRelativeAddr = address - lvlStartAddr

        idc.Message("Address relative to file: 0x" + format(fileRelativeAddr, '02X') + "\n") 


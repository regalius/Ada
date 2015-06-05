
extends "../../abstract_dialog.gd"


func init():
	.init()
	self.initButtonStates()
	
func initReferences():
	.initReferences()
	references["soundItem"] = self.get_node("menu_container/sound_item")
	references["languageItem"] = self.get_node("menu_container/language_item")
	references["soundBtnOn"] = references["soundItem"].get_node("container/btn_1")
	references["soundBtnOff"] = references["soundItem"].get_node("container/btn_2")
	references["languageBtnEn"] = references["languageItem"].get_node("container/btn_1")
	references["languageBtnIn"] = references["languageItem"].get_node("container/btn_2")
	references["backBtn"] = self.get_node("backbtn/backbtn")
	pass

#func initConnections():
	references["soundBtnOn"].connect("pressed", self, "changeSettings",["SOUND_ENABLED", "On",references["soundItem"]])
	references["soundBtnOff"].connect("pressed", self, "changeSettings",["SOUND_ENABLED", "Off",references["soundItem"]])
	references["languageBtnEn"].connect("pressed", self, "changeSettings",["LANGUAGE", "en",references["languageItem"]])
	references["languageBtnIn"].connect("pressed", self, "changeSettings",["LANGUAGE", "in",references["languageItem"]])
	references["backBtn"].connect("pressed", references["guiRoot"], "showDialog",[false, "", "option",""])
#	pass

func initButtonStates():
	references["soundItem"].init("Sound","On", "Off", references["rootNode"].getSettings("SOUND_ENABLED"))
	references["languageItem"].init("Language", "en", "in", references["rootNode"].getSettings("LANGUAGE"))
#	if references["rootNode"].getSettings("SOUND_ENABLED"):
#		references["soundBtnOn"].set_disabled(true)
#		references["soundBtnOff"].set_disabled(false)
#	else:
#		references["soundBtnOff"].set_disabled(true)
#		references["soundBtnOn"].set_disabled(false)
#		
#	if references["rootNode"].getSettings("LANGUAGE") == "en":
#		references["languageBtnEn"].set_disabled(true)
#		references["languageBtnIn"].set_disabled(false)
#	else:
#		references["languageBtnIn"].set_disabled(true)
#		references["languageBtnEn"].set_disabled(false)
#	pass

func changeSettings(settingName, newValue, currentItem):
	if references["rootNode"].getSettings(settingName) != newValue:
		references["rootNode"].changeSettings(settingName, newValue)
		currentItem.setValue(newValue)
	pass
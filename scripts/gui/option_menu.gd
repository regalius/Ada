
extends "../abstract_gui.gd"


func init():
	.init()
	initButtonStates()
	
func initReferences():
	.initReferences()
	references["soundBtnOn"] = self.get_node("center/menu/sound_menu/soundBtnGroup/soundbtn_on")
	references["soundBtnOff"] = self.get_node("center/menu/sound_menu/soundBtnGroup/soundbtn_off")
	references["languageBtnEn"] = self.get_node("center/menu/language_menu/languageBtnGroup/languagebtn_en")
	references["languageBtnIn"] = self.get_node("center/menu/language_menu/languageBtnGroup/languagebtn_in")
	references["backBtn"] = self.get_node("center/menu/backbtn/backbtn")
	references["rootNode"] = self.get_node("/root").get_child(self.get_node("/root").get_child_count()-1)
	pass

func initConnections():
	references["soundBtnOn"].connect("pressed", self.get_parent(), "buttonPressed", ["changeSettings",["SOUND_ENABLED", true,references["soundBtnOn"]]])
	references["soundBtnOff"].connect("pressed", self.get_parent(), "buttonPressed", ["changeSettings",["SOUND_ENABLED", false,references["soundBtnOff"]]])
	references["languageBtnEn"].connect("pressed", self.get_parent(), "buttonPressed", ["changeSettings",["LANGUAGE", "en",references["languageBtnEn"]]])
	references["languageBtnIn"].connect("pressed", self.get_parent(), "buttonPressed", ["changeSettings",["LANGUAGE", "in",references["languageBtnIn"]]])
	references["backBtn"].connect("pressed", self.get_parent(), "buttonPressed", ["setCurrentGUI",["mainMenu"]])
	pass

func initButtonStates():
	if references["rootNode"].getSettings("SOUND_ENABLED"):
		references["soundBtnOn"].set_disabled(true)
		references["soundBtnOff"].set_disabled(false)
	else:
		references["soundBtnOff"].set_disabled(true)
		references["soundBtnOn"].set_disabled(false)
		
	if references["rootNode"].getSettings("LANGUAGE") == "en":
		references["languageBtnEn"].set_disabled(true)
		references["languageBtnIn"].set_disabled(false)
	else:
		references["languageBtnIn"].set_disabled(true)
		references["languageBtnEn"].set_disabled(false)
	pass

func changeSettings(settingName, newValue, currentBtn):
	var btnGroup = currentBtn.get_parent()
	if(references["rootNode"].getSettings(settingName) != newValue):
		references["rootNode"].changeSettings(settingName, newValue)
		for button in btnGroup.get_button_list():
			button.set_disabled(false)
		currentBtn.set_disabled(true)
	pass

extends "../abstract_gui.gd"

var dialogType = {
	"quit":{
		"titleLbl":"Quit Game",
		"textLbl":"Are you sure you want to quit ?",
		"action":"quitGame",
		"parameter":""
	},
	"levelMenu":{
		"titleLbl":"Level Menu",
		"textLbl":"Do you want to go back to level selection menu ?",
		"action":"quitLevel",
		"parameter":""
	},
}

func init():
	.init()
	self.initCurrents()

func initReferences():
	.initReferences()
	references["yesBtn"] = self.get_node("center/dialog/dialog_btn/yes_btn")
	references["noBtn"] = self.get_node("center/dialog/dialog_btn/no_btn")
	references["textLbl"] = self.get_node("center/dialog/dialog_lbl")
	references["titleLbl"] = self.get_node("center/dialog/dialog_title")
	
func initCurrents():
	currents={
		"dialogType":""
	}
func initConnections():
	references["noBtn"].connect("pressed", self.get_parent(), "buttonPressed",["showDialog",[false,""]])

func setDialogType(type):
	if type != currents["dialogType"]:
		currents["dialogType"] = type
		references["textLbl"].set_text(dialogType[type].textLbl)
		references["titleLbl"].set_text(dialogType[type].titleLbl)
		references["yesBtn"].disconnect("pressed", self.get_parent(), "buttonPressed")
		references["yesBtn"].connect("pressed", self.get_parent(), "buttonPressed",[dialogType[type].action,dialogType[type].parameter])
	
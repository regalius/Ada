
extends "../abstract_gui.gd"

# member variables here, example:
# var a=2
# var b="textvar"

var dialogType = {
	"quitDialog":"",
	"confirmMenuDialog":""
}

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

func init(type):
	.init()
	self.initCurrents()
	self.setDialogType(type)

func setDialogType(type):
	currents["dialogType"] = type
	
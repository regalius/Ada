
extends "../../abstract_dialog.gd"


func initReferences():
	.initReferences()
	references["textLbl"] = self.get_node("text_container/text_lbl")
	references["okBtn"] = self.get_node("btn_container/ok_btn")
	
func initConnections():
	references["okBtn"].connect("pressed",references["guiRoot"],"showDialog",[false,"","alert",""])
	
func enterDialog(sender, parameter):
	.enterDialog(sender, parameter)
	self.setText(parameter[0])

func setText(text):
	references["textLbl"].set_text(text)
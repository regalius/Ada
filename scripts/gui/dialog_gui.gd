
extends "../abstract_gui.gd"

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Initialization here
	pass

func init():
	.init()
	for dialog in references["dialogContainer"].get_children():
		dialog.init()
	pass

func initReferences():
	.initReferences()
	references["dialogContainer"] = self.get_node("dialog_container")
	references["yesno"] = self.get_node("dialog_container/yesnodialog_root")
	references["alert"] = self.get_node("dialog_container/alertdialog_root")
	references["option"] = self.get_node("dialog_container/optiondialog_root")
	references["gameResult"] = self.get_node("dialog_container/resultdialog_root")
	references["objectEdit"] = self.get_node("dialog_container/objecteditdialog_root")
	references["levelDataEdit"] = self.get_node("dialog_container/leveldataeditdialog_root")
	pass

func initConnections():
	pass
	
func setDialogType(sender, type, parameter):
	for dialog in references["dialogContainer"].get_children():
		dialog.hide()
		
	if references.has(type):
		references[type].show()
		references[type].enterDialog(sender, parameter)
		currents["dialog"] = references[type]

func getCurrentDialog():
	return currents["dialog"]
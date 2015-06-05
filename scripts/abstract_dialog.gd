extends "abstract_gui.gd"

func enterDialog(sender, parameter):
	self.setSender(sender)
	pass

func exitDialog():
	pass
	
func setSender(sender):
	currents["sender"] = sender
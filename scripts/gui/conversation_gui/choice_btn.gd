extends "../button.gd"


func attachToConversationGUI(conversationGUI, value):
	references["conversationGUI"] = conversationGUI
	self.setValue(value)
	self.initConnections()
	
func initConnections():
	self.connect("pressed",self,"doNextAction")
	pass

func doNextAction():
	references["conversationGUI"].setValueChosen(currents["value"])
	references["conversationGUI"].doNextAction()

func setValue(value):
	currents["value"] = value 
	self.set_text(TranslationServer.tr(str(value)))

func getValue():
	return currents["value"]
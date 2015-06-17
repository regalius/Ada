
extends "../abstract_gui.gd"


func _ready():
	# Initialization here
	pass

func initReferences():
	.initReferences()
	references["conversation"] = self.get_node("conversation")
	references["conversationLbl"] = references["conversation"].get_node("conversation_lbl")
	references["conversationBtn"] = references["conversation"].get_node("next")
	references["next"] = self.get_node("next")
	references["nameLbl"] = references["conversation"].get_node("name_lbl")
	references["focusedItem"] = self.get_node("center/focused_item")
	references["animation"] = self.get_node("animation")
	pass

func initConnections():
	.initConnections()
	references["conversationBtn"].connect("pressed", self, "doNextAction")
	references["next"].connect("pressed", self, "doNextAction")
	pass

func initCurrents(sender, conversationDict):
	currents["sender"] = sender
	currents["conversation"]= conversationDict
	pass

func startConversation(sender, conversationDict):
	self.initCurrents(sender, conversationDict)
	references["animation"].clear_queue()
	references["animation"].stop(true)
	self.goTo(0)
	
	
func endConversation():
	references["guiRoot"].showConversation(false,currents["sender"], "")
	
func doNextAction():
	print(references["animation"].get_current_animation())
	if references["animation"].is_playing() and references["animation"].get_current_animation() == "typewrite_conversation":
		references["animation"].seek(references["animation"].get_current_animation_length(),true)
		references["animation"].play("btn_anim")
	else:
		references["animation"].stop(true)
		self.doAction(currents["displayedConversation"].nextAction)
	pass

func doCurrentAction():
	self.doAction(currents["displayedConversation"].currentAction)
	pass

func doAction(actionArray):
	if not actionArray.empty():
		for action in actionArray: 
			var actionName = action[0]
			
			if actionName == "goTo":
				self.goTo(action[1][0])
			elif actionName =="showFocusedItem":
				self.showFocusedItem(action[1][0],action[1][1])
			elif actionName == "endConversation":
				self.endConversation()
			elif actionName == "showResultMenu":
				currents["sender"].showResultMenu()
	pass
	
func goTo(index):
	references["animation"].clear_queue()
	currents["displayedConversation"] = currents["conversation"][index]
	references["conversationLbl"].hide()
	references["conversationLbl"].set_text(TranslationServer.tr(currents["displayedConversation"].text))
	references["nameLbl"].set_text(TranslationServer.tr(currents["displayedConversation"].actor.capitalize()))
	self.doCurrentAction()
	references["animation"].queue("portrait_changed_"+currents["displayedConversation"].actor+"_"+currents["displayedConversation"].emotion)
	references["animation"].queue("typewrite_conversation")
	pass

func showFocusedItem(show,itemName):
	if show:
		references["focusedItem"].show()
		references["animation"].queue("show_focused_item_"+itemName)
	else:
		references["focusedItem"].hide()
	pass
	
	
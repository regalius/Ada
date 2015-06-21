
extends "../abstract_gui.gd"


func _ready():
	# Initialization here
	pass

func _conversation_start():
	self.goTo([0])
	references["conversationBtn"].connect("pressed", self, "doNextAction")
	references["next"].connect("pressed", self, "doNextAction")

func _conversation_end():
	references["guiRoot"].showConversation(false,currents["sender"], "")

func initReferences():
	.initReferences()
	references["conversation"] = self.get_node("conversation")
	references["conversationLbl"] = references["conversation"].get_node("conversation_lbl")
	references["conversationName"] = references["conversation"].get_node("name_lbl")
	references["conversationPortrait"] = references["conversation"].get_node("portrait")
	references["conversationBtn"] = references["conversation"].get_node("next")
	references["next"] = self.get_node("next")
	references["focusedItem"] = self.get_node("center/focused_item")
	references["animation"] = self.get_node("animation")
	pass


func initCurrents(sender, conversationDict):
	currents["sender"] = sender
	currents["conversation"]= conversationDict
	pass

func startConversation(sender, conversationDict):
	self.initCurrents(sender, conversationDict)
#	self.resetConversation()
	references["animation"].clear_queue()
	references["animation"].stop(true)
	references["animation"].play("conversation_start")	
	
func doNextAction():
	if references["animation"].is_playing() and references["animation"].get_current_animation() == "typewrite_conversation":
		references["animation"].seek(references["animation"].get_current_animation_length(),true)
		references["animation"].play("btn_anim")
	else:
		if currents["displayedConversation"].nextAction.has(currents["displayedConversation"].valueChosen):
			references["animation"].stop(true)
			self.doAction(currents["displayedConversation"].nextAction[currents["displayedConversation"].valueChosen])
	pass

func doCurrentAction():
	self.doAction(currents["displayedConversation"].currentAction)
	pass

func doAction(actionArray):
	if not actionArray.empty():
		for action in actionArray: 
			self.call(action[0],action[1])
	pass
	
func goTo(args):
	var index = args[0]
	
	currents["displayedConversation"] = currents["conversation"][index]
	currents["displayedConversation"]["valueChosen"] = 1
	references["conversationLbl"].hide()
	references["conversationLbl"].set_text(TranslationServer.tr(currents["displayedConversation"].text))
	references["conversationName"].set_text(TranslationServer.tr(currents["displayedConversation"].name.capitalize()))
	
	if currents["displayedConversation"].nextAction.size() > 1:
		print(currents["displayedConversation"].nextAction)
		currents["displayedConversation"]["valueChosen"] = "YES"
		
	self.doCurrentAction()
	references["animation"].clear_queue()
	references["animation"].queue("portrait_changed_"+currents["displayedConversation"].actor+"_"+currents["displayedConversation"].emotion)
	references["animation"].queue("typewrite_conversation")
	pass

func showFocusedItem(args):
	var show = args[0]
	var itemName = args[1]
	if show:
		references["focusedItem"].show()
		references["animation"].queue("show_focused_item_"+itemName)
	else:
		references["focusedItem"].hide()
	pass
	
func resetConversation():
	references["conversationPortrait"].set_texture(null)
	references["conversationLbl"].set_text("")
	references["conversationName"].set_text("")

func endConversation(args):
	references["conversationBtn"].disconnect("pressed", self, "doNextAction")
	references["next"].disconnect("pressed", self, "doNextAction")
	references["animation"].play("conversation_end")

func showResultMenu(args):
	currents["sender"].showResultMenu()

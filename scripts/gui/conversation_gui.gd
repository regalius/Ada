
extends "../abstract_gui.gd"

func init():
	prefabs= {
		"choiceBtn" : preload("res://gui/conversation_gui/choice_btn.scn")
	}
	.init()
	

func _conversation_start():
	self.goTo([0])
	references["next"].connect("pressed", self, "doNextAction")
	references["skipBtn"].connect("pressed",self,"skipConversation",[""])

func _conversation_end():
	references["guiRoot"].showConversation(false,currents["sender"], "")

func _typewriter_finished():
	if currents["displayedConversation"].nextAction.size() > 1:
		references["animation"].play("show_conversation_choice")
	else:
		references["animation"].play("btn_anim")

func _show_focused_item_piece(args):
	self.get_node("center/focused_item/container/Piece").setAction(args)

func _show_focused_item_function_container(args):
	self.get_node("center/focused_item/container/piececontainer_root").setTitle(args)
		
func initReferences():
	.initReferences()
	references["tutorialUI"] = references["guiRoot"].get_node("gui_container/tutorial_root")
	references["conversation"] = self.get_node("conversation")
	references["conversationLbl"] = references["conversation"].get_node("conversation_lbl")
	references["conversationName"] = references["conversation"].get_node("name_lbl")
	references["conversationPortrait"] = references["conversation"].get_node("portrait")
	references["next"] = self.get_node("next")
	references["skipBtn"] = self.get_node("top_right/skip_btn")
	references["focusedItem"] = self.get_node("center/focused_item")
	references["conversationChoice"] = self.get_node("center/conversation_choice")
	references["animation"] = self.get_node("animation")
	pass


func initCurrents(sender, conversationDict):
	currents["sender"] = sender
	currents["conversation"]= conversationDict
	pass

func startConversation(sender, conversationDict):
	self.initCurrents(sender, conversationDict)
	self.resetConversation()
	
func doNextAction():
	if references["animation"].is_playing() and references["animation"].get_current_animation() == "typewrite_conversation":
		references["animation"].seek(references["animation"].get_current_animation_length(),true)
		self._typewriter_finished()
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

func clearConversationChoice():
	if references["conversationChoice"].is_visible():
		for choice in references["conversationChoice"].get_node("container").get_children():
			references["conversationChoice"].get_node("container").remove_child(choice)
			choice.queue_free()
		references["conversationChoice"].hide()
	
func goTo(args):
	var index = args[0]
	
	self.clearConversationChoice()
	
	currents["displayedConversation"] = currents["conversation"][index]
	currents["displayedConversation"]["valueChosen"] = 1
	references["conversationLbl"].hide()
	references["conversationLbl"].set_text(TranslationServer.tr(currents["displayedConversation"].text))
	references["conversationName"].set_text(TranslationServer.tr(currents["displayedConversation"].name.capitalize()))
	references["animation"].clear_queue()
	
	self.doCurrentAction()

	references["animation"].queue("portrait_changed_"+currents["displayedConversation"].actor+"_"+currents["displayedConversation"].emotion)
	
	if currents["displayedConversation"].nextAction.size() > 1:
		for branch in currents["displayedConversation"].nextAction:
			var newChoice = prefabs["choiceBtn"].instance()
			references["conversationChoice"].get_node("container").add_child(newChoice)
			newChoice.attachToConversationGUI(self,branch)
			
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
	self.clearConversationChoice()
	references["animation"].clear_queue()
	references["animation"].stop(true)
	references["animation"].play("conversation_start")

func endConversation(args):
	references["next"].disconnect("pressed", self, "doNextAction")
	references["skipBtn"].disconnect("pressed",self,"skipConversation")
	references["animation"].play("conversation_end")

func skipConversation(args):
	self.doAction(currents["conversation"].skipAction)
	self.endConversation(args)
	
func showResultMenu(args):
	currents["sender"].showResultMenu()

func goToNextTutorialStep(args):
	references["tutorialUI"].goToNextStep()

func setValueChosen(value):
	currents["displayedConversation"].valueChosen = value

func getValueChosen():
	return currents["displayedConversation"].valueChosen

extends "../abstract_gui.gd"

# member variables here, example:
# var a=2
# var b="textvar"	
func init():
	.init()
	prefabs = {
		"levelBtn" : preload("res://gui/button/level_button.scn"),
		"levelContainer" :preload("res://gui/container/level_container.scn"),
	}
	createLevelSelector()
	initCurrents()
	references["levelBtnContainer"].get_child(currents["sectionIndex"]).show()
	references["prevBtn"].hide()
	references["maxLbl"].set_text(str(currents["maxSectionIndex"]+1))
	references["currentLbl"].set_text(str(currents["sectionIndex"]+1))
	
func initReferences():
	references = {
		"prevBtn":"",
		"nextBtn":"",
		"backBtn":"",
		"currentLbl":"",
		"maxLbl":"",
		"levelBtnContainer":"",
		"rootNode":"",
	}
	references["prevBtn"] = self.get_node("bot_left/prev_btn")
	references["nextBtn"] = self.get_node("bot_right/next_btn")
	references["backBtn"] = self.get_node("top_right/back_btn")
	references["currentLbl"] = self.get_node("bot_center/screen_label/current_lbl")
	references["maxLbl"] = self.get_node("bot_center/screen_label/max_lbl")
	references["levelBtnContainer"] = self.get_node("top_center")
	references["rootNode"] = self.get_node("/root").get_child(self.get_node("/root").get_child_count()-1)
	pass

func initConnections():
	references["backBtn"].connect("pressed", self.get_parent(), "buttonPressed",["setCurrentGUI",["mainMenu"]])
	references["prevBtn"].connect("pressed", self.get_parent(), "buttonPressed", ["setLevelSection",["prev"]])
	references["nextBtn"].connect("pressed", self.get_parent(), "buttonPressed", ["setLevelSection",["next"]])
	pass

func initCurrents():
	currents ={
		"sectionIndex": 0,
		"maxSectionIndex":0
	}
	currents["sectionIndex"] = 0
	currents["maxSectionIndex"] = references["levelBtnContainer"].get_child_count() - 1

func createLevelSelector():
	var tempContainer
	var tempLevel
	var tempIndex
	for container in references["rootNode"].mapReferences:
		tempContainer = prefabs["levelContainer"].instance()
		references["levelBtnContainer"].add_child(tempContainer)
		tempContainer.hide()
		tempContainer.setTitle(container)
		tempIndex = 1
		for level in references["rootNode"].mapReferences[container]:
			var temp = references["rootNode"].mapReferences[container][level] 
			tempLevel = prefabs["levelBtn"].instance()
			tempContainer.references["container"].add_child(tempLevel)
			tempLevel.init(temp["mapPath"],temp["unlocked"],temp["bestCandy"], tempIndex)
			tempIndex+=1
	pass

func setLevelSection(command):
	for container in references["levelBtnContainer"].get_children():
		container.hide()
	
	if command == "prev":
		currents["sectionIndex"]-=1
	else:
		currents["sectionIndex"]+=1
	
	if references["levelBtnContainer"].get_child(currents["sectionIndex"]):
		references["levelBtnContainer"].get_child(currents["sectionIndex"]).show()
		
		if(currents["sectionIndex"] == 0):
			references["prevBtn"].hide()
			references["nextBtn"].show()
		elif (currents["sectionIndex"] == currents["maxSectionIndex"]):
			references["nextBtn"].hide()
			references["prevBtn"].show()
		else:
			references["prevBtn"].show()
			references["nextBtn"].show()	
		references["currentLbl"].set_text(str(currents["sectionIndex"]+1))
	pass

extends "../abstract_gui.gd"

# member variables here, example:
# var a=2
# var b="textvar"	
func init():
	.init()
	prefabs = {
		"levelBtn" : preload("res://gui/level_menu/level_button.scn"),
		"levelContainer" :preload("res://gui/level_menu/level_container.scn"),
	}
	self.initCurrents()
	self.createLevelSelector()
	references["levelBtnContainer"].get_child(currents["sectionIndex"]).show()
	references["prevBtn"].hide()
	references["maxLbl"].set_text(str(currents["maxSectionIndex"]+1))
	references["currentLbl"].set_text(str(currents["sectionIndex"]+1))
	
func initReferences():
	.initReferences()
	references["prevBtn"] = self.get_node("bot_left/prev_btn")
	references["nextBtn"] = self.get_node("bot_right/next_btn")
	references["backBtn"] = self.get_node("top_right/back_btn")
	references["currentLbl"] = self.get_node("bot_center/screen_label/current_lbl")
	references["maxLbl"] = self.get_node("bot_center/screen_label/max_lbl")
	references["levelBtnContainer"] = self.get_node("top_center")
	pass

func initConnections():
	references["backBtn"].connect("pressed", self.get_parent(), "buttonPressed",["setCurrentGUI",["mainMenu"]])
	references["prevBtn"].connect("pressed", self.get_parent(), "buttonPressed", ["setLevelSection",["prev"]])
	references["nextBtn"].connect("pressed", self.get_parent(), "buttonPressed", ["setLevelSection",["next"]])
	pass

func initCurrents():
	currents["sectionIndex"] = 0
	currents["maxSectionIndex"] = 0
	currents["levelSelectorIndex"]={}
	
func createLevelSelector():
	var tempContainer
	var tempLevel
	var maxSectionIndex = 0
	for container in references["rootNode"].mapReferences:
		tempContainer = prefabs["levelContainer"].instance()
		references["levelBtnContainer"].add_child(tempContainer)
		tempContainer.hide()
		tempContainer.init(container,references["rootNode"].mapReferences[container].title)
		currents["levelSelectorIndex"][container]={}
		currents["levelSelectorIndex"][container]["container"] = tempContainer
		for level in references["rootNode"].mapReferences[container]["levels"]:
			var temp = references["rootNode"].mapReferences[container]["levels"][level] 
			tempLevel = prefabs["levelBtn"].instance()
			tempContainer.references["container"].add_child(tempLevel)
			tempLevel.init({"containerIndex":container,"levelIndex":level},temp["unlocked"],temp["bestCandy"])
			currents["levelSelectorIndex"][container][level] = tempLevel 
		
		maxSectionIndex+=1
		
	currents["maxSectionIndex"] = maxSectionIndex -1


func updateLevelSelector():
	var tempContainer
	var tempLevel
	var maxSectionIndex = 0
	for container in references["rootNode"].mapReferences:
		if currents["levelSelectorIndex"][container]["container"] == null:
			tempContainer = prefabs["levelContainer"].instance()
			references["levelBtnContainer"].add_child(tempContainer)
			tempContainer.hide()
			tempContainer.init(container, references["rootNode"].mapReferences[container].title)
			currents["levelSelectorIndex"][container]["container"] = tempContainer
		
		currents["levelSelectorIndex"][container]["container"].init(container, references["rootNode"].mapReferences[container].title)

		for level in references["rootNode"].mapReferences[container]["levels"]:
			var temp = references["rootNode"].mapReferences[container]["levels"][level] 
			if currents["levelSelectorIndex"][container][level] == null:
				tempLevel = prefabs["levelBtn"].instance()
				tempContainer.references["container"].add_child(tempLevel)
				tempLevel.init({"containerIndex":container,"levelIndex":level},temp["unlocked"],temp["bestCandy"])
				currents["levelSelectorIndex"][container][level] = tempLevel 
			
			currents["levelSelectorIndex"][container][level].init({"containerIndex":container,"levelIndex":level},temp["unlocked"],temp["bestCandy"])
		maxSectionIndex+=1
		
	currents["maxSectionIndex"] = maxSectionIndex -1
	

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
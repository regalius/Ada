
extends "../../abstract_dialog.gd"

func init():
	.init()
	self.initCurrents()
	pass

func initReferences():
	.initReferences()
	references["scoreLbl"] = self.get_node("score_lbl")
	references["candyContainer"] = self.get_node("center/candy_container")
	references["retryBtn"] = self.get_node("bottom/menu_btn/retry_btn")
	references["backBtn"] = self.get_node("bottom/menu_btn/back_btn")
	references["nextBtn"] = self.get_node("bottom/menu_btn/next_btn")

func initConnections():
	references["backBtn"].connect("pressed",references["rootNode"],"quitLevel")
	references["nextBtn"].connect("pressed",self,"startNextLevel")
	references["retryBtn"].connect("pressed",references["rootNode"],"retryLevel")
	pass

func initCurrents():
	currents={
		"score":"",
		"candy":"",
	}

func enterDialog(sender, parameter):
	.enterDialog(sender, parameter)
	self.setScore(parameter[0])
	self.setCandy(parameter[1])
	self.setPreviewMode(parameter[2])
	pass

func setPreviewMode(state):
	if state:
		references["backBtn"].disconnect("pressed",references["rootNode"],"quitLevel")
		references["nextBtn"].disconnect("pressed",self,"startNextLevel")
		
		references["backBtn"].connect("pressed",references["rootNode"],"quitPreviewMode")
		references["nextBtn"].connect("pressed",references["rootNode"],"quitPreviewMode")
	else:
		references["backBtn"].disconnect("pressed",references["rootNode"],"quitPreviewMode")
		references["nextBtn"].disconnect("pressed",references["rootNode"],"quitPreviewMode")

		references["backBtn"].connect("pressed",references["rootNode"],"quitLevel")
		references["nextBtn"].connect("pressed",self,"startNextLevel")
	
	
func startNextLevel():
	references["rootNode"].startLevel(references["rootNode"].getNextLevel())
	
func setScore(score):
	currents["score"] = score
	references["scoreLbl"].set_text(str(score))

func setCandy(num):
	currents["candy"] = num
	for candy in references["candyContainer"].get_children():
		candy.set_disabled(true)
	for i in range(currents["candy"]):
		references["candyContainer"].get_child(i).set_disabled(false)
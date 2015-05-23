
extends "../abstract_gui.gd"

func init():
	.init()
	self.initCurrents()
	pass

func initReferences():
	.initReferences()
	references["scoreLbl"] = self.get_node("center/menu/score_lbl")
	references["candyContainer"] = self.get_node("center/menu/candy_container")
	references["retryBtn"] = self.get_node("center/menu/menu_btn/retry_btn")
	references["backBtn"] = self.get_node("center/menu/menu_btn/back_btn")
	references["nextBtn"] = self.get_node("center/menu/menu_btn/next_btn")

func initConnections():
	references["backBtn"].connect("pressed",self.get_parent(),"buttonPressed",["quitLevel",""])
	references["nextBtn"].connect("pressed",self.get_parent(),"buttonPressed",["startNextLevel",""])
	references["retryBtn"].connect("pressed",self.get_parent(),"buttonPressed",["retryLevel",""])
	pass

func initCurrents():
	currents={
		"score":"",
		"candy":"",
	}

func setScore(score):
	currents["score"] = score
	references["scoreLbl"].set_text(str(score))

func setCandy(num):
	currents["candy"] = num
	for candy in references["candyContainer"].get_children():
		candy.set_disabled(true)
	for i in range(currents["candy"]):
		references["candyContainer"].get_child(i).set_disabled(false)
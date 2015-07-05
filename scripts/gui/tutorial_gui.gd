
extends "../abstract_gui.gd"

func init():
	.init()
	self.initCurrents()

func _tutorial_end():
	references["guiRoot"].showTutorial(false,currents["sender"],[])
	references["animation"].play("reset")

func _tutorial_start():
	self.setMargin(references["funcTutorial"],references["funcTutorial"].get_size().x,0,0,0)
	self.goToStep(0)

func _editor_tutorial_start():
	var margin = references["toolboxTutorial"].get_size().x +150
	self.setMargin(references["toolboxTutorial"], 50,margin,0,margin)

func _play_solver_algorithm_start():
	references["playBtnTutorial"].set_size(Vector2(0,0))
	var margin = references["playBtnTutorial"].get_size().x +120
	self.setMargin(references["playBtnTutorial"], 20,margin,30,margin)

func grab_piece(args):
	references["dragTutorialPiece"].setAction(args[0])

func drop_piece(args):
	references["funcTutorialPiece"].setAction(args[0])
	var funcVMargin = 0
	if args[1] != "M":
		funcVMargin = int(args[1].split("F")[1]) * 165
	references["funcTutorial"].set_size(Vector2(0,0))
	var leftMargin = 0
	var topMargin = 0
	var index = int(args[2])
	if index <=5:
		leftMargin = references["funcTutorial"].get_size().x - (index%6 - 1) * references["funcTutorialPiece"].get_size().x 
	else:
		leftMargin = references["funcTutorial"].get_size().x - (index%5 - 1) * references["funcTutorialPiece"].get_size().x 
		topMargin =(int(args[2])/5) * references["funcTutorialPiece"].get_size().y
	topMargin+=funcVMargin
	
	self.setMargin(references["funcTutorial"], topMargin,leftMargin,0,0)
#	print(str(leftMargin)+ " | " + str(topMargin)+ " | "+ str(references["funcTutorial"].get_size().x))
		
func initReferences():
	.initReferences()
	references["animation"] = self.get_node("animation")
	references["dragTutorialPiece"] = self.get_node("game_bot_center/piece_tutorial/container/Piece")
	references["funcTutorialContainer"] = self.get_node("game_func_container")
	references["funcTutorial"] = references["funcTutorialContainer"].get_node("func_container_tutorial")
	references["funcTutorialPiece"] = references["funcTutorial"].get_node("container/Piece")
	references["toolboxTutorial"] = self.get_node("editor_right")
	references["playBtnTutorial"] = self.get_node("game_top/top_right/play_btn_tutorial")
	
func initCurrents():
	.initCurrents()
	currents["step"]=""
	currents["stepIndex"]=0
	currents["tutorialArray"] = []
	currents["sender"] = null
	
func startTutorial(sender, tutorialArray):
	currents["tutorialArray"] = tutorialArray
	currents["step"]=""
	currents["sender"] = sender	
	references["animation"].play("reset")
	references["animation"].play("tutorial_start")
	
func goToStep(step):
	currents["stepIndex"]=step
	if currents["stepIndex"] < currents["tutorialArray"].size():
		currents["step"] = currents["tutorialArray"][step]
		var anim = currents["step"].split(".")
		references["animation"].play("reset")
		references["animation"].queue(anim[0])
		if anim.size()> 1:
			var args = []
			for i in range(1,anim.size()):
				args.append(anim[i])
			self.call(anim[0],args)
	
#			print(anim)
	else:
		references["animation"].queue("tutorial_end")
		
func goToNextStep():
	currents["stepIndex"]+=1
	self.goToStep(currents["stepIndex"])
	
func getCurrentStep():
	return currents["step"]
	
func setMargin(control,top,left,bot,right):
	control.set_margin(MARGIN_TOP, top)
	control.set_margin(MARGIN_LEFT, left)
	control.set_margin(MARGIN_BOTTOM, bot)
	control.set_margin(MARGIN_RIGHT, right)
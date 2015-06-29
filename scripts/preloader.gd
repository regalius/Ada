
extends Control

var curTrivia = 0


func _ready():
	# Initialization here
	self.get_node("timer").connect("timeout",self,"startGame")
	self.get_node("animation").play("please_wait")
	self.get_node("player_control/Player/animation").play("idle_left")
	self.updateTrivia()
	pass

func startGame():
	print("preloaded")
	self.get_node("timer").disconnect("timeout",self,"startGame")
	self.get_node("timer").set_wait_time(3)
	self.get_node("timer").connect("timeout",self,"updateTrivia")
	self.get_node("timer").start()
	self.get_node("/root/global").startGame()

func updateTrivia():
	randomize()
	var random = randi()%4
	print(random)
	while random == curTrivia:
		randomize()
		random = randi()%4
	curTrivia = random
	self.get_node("center/grid/trivia/trivia_text").set_text(TranslationServer.tr("TRIVIA_"+ str(curTrivia)))
	self.get_node("timer").start()

func updateProgress(progress):
	self.get_node("progress/progress_bar").set_value(progress*100)

func queueNewScene(resource):
	self.get_node("timer").disconnect("timeout",self,"updateTrivia")
	self.get_node("timer").stop()
	self.get_node("timer").set_wait_time(1)
	self.get_node("timer").connect("timeout",self.get_node("/root/global"),"setNewScene",[resource])
	self.get_node("timer").start()
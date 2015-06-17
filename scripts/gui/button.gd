extends Button

var currents={}

var references={}

func _ready():
	self.init()
	pass

func init():
	self.initReferences()
	self.initCurrents()
	self.initConnections()

func initReferences():
	references["rootNode"] = self.get_node("/root").get_child(self.get_node("/root").get_child_count()-1)
	pass

func initCurrents():
	pass

func initConnections():
	pass

func _input_event(event):
	if event.type == InputEvent.MOUSE_BUTTON:
		if not event.pressed :
			references["rootNode"].references["soundController"].playSFX("click",true)

	if references["rootNode"].isMapStarted():
		references["rootNode"].references["inputController"]._input(event,self,"gui")
	pass

extends ScrollContainer

var references= {}

func _ready():
	# Initialization here
#	self.get_node("_v_scroll").set_opacity(0)
	self.init()
	pass

func init():
	self.initReferences()

func initReferences():	
	references["rootNode"] = self.get_node("/root").get_child(self.get_node("/root").get_child_count()-1)

func _input_event(event):
	references["rootNode"].references["inputController"]._input(event,self,"gui")	
	self.get_node("_v_scroll")._input_event(event)

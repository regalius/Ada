
extends Control

# member variables here, example:
# var a=2
# var b="textvar"

var references = {
	"sectionContainer":"",
	"paginationContainer":"",
	"prevBtn":"",
	"nextBtn":"",
	"guiRoot":"",
	"rootNode":""
}

var currents = {
	"sectionIndex":0
}

func _ready():
	# Initialization here
	self.init()
	pass

func init():
	self.initReferences()
	self.initConnections()
	self.setToSection(0)

func _input_event(event):
	references["rootNode"].references["inputController"]._input(event,self,"gui")
	
func initReferences():
	references["sectionContainer"]= self.get_node("section_container")
	references["paginationContainer"]= self.get_node("pagination_container/pagination")
	references["prevBtn"] = self.get_node("navigation_container/prev_btn")
	references["nextBtn"] = self.get_node("navigation_container/next_btn")
	references["rootNode"] = self.get_node("/root").get_child(self.get_node("/root").get_child_count()-1)
	references["guiRoot"] = references["rootNode"].getGUIRoot()
	
func initConnections():
	references["prevBtn"].connect("pressed", self, "changeSection", ["prev"])
	references["nextBtn"].connect("pressed", self, "changeSection", ["next"])
	pass

func changeSection(command):
	if command == "prev":
		self.setToSection(currents["sectionIndex"]-1)
	elif command == "next":
		self.setToSection(currents["sectionIndex"]+1)
		
func setToSection(index):
	if index < 0:
		index = references["sectionContainer"].get_child_count() -1
	elif index >= references["sectionContainer"].get_child_count():
		index = 0

	for section in references["sectionContainer"].get_children():
		section.hide()
	references["sectionContainer"].get_child(index).show()
	
	for pagination in references["paginationContainer"].get_children():
		pagination.set_disabled(false)
		
	references["paginationContainer"].get_child(index).set_disabled(true)

	currents["sectionIndex"] = index

func resetButton():
	for container in references["sectionContainer"].get_children():
		for btn in container.get_children():
			btn.set_disabled(false)

func reset():
	self.resetButton()
	references["sectionContainer"].get_child(0).get_node("delete_btn").setActiveBrush()
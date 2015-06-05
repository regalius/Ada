extends "../../abstract_dialog.gd"

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Initialization here
#	self.enterDialog(["house", {"x":0,"y":0,"z":0,"groundType":2,"objectAttribute":{"houseValue":10, "direction": "front"}}])
	pass

func initReferences():
	.initReferences()
	references["object"] = self.get_node("object")
	references["house"] = references["object"].get_node("house")
	references["saveBtn"] = self.get_node("confirm_btn/save_btn")
	references["cancelBtn"] = self.get_node("confirm_btn/cancel_btn")
	pass
	
func initConnections():
	references["cancelBtn"].connect("pressed", references["guiRoot"], "showDialog",[false,"", "objectEdit",""])
	references["saveBtn"].connect("pressed",self, "saveAttribute")
	pass

func enterDialog(sender, parameter):
	.enterDialog(sender, parameter)
	self.setObjectType(parameter[0])
	self.setCellEdited(parameter[1])
	self.displayData()
	pass
	
func exitDialog():
	pass

func displayData():
	for object in references["object"].get_children():
		object.hide()
	references[currents["object"]].show()

	for item in currents["cellEdited"].objectAttribute:
		references[currents["object"]].get_node("item_container/"+item).init(item, currents["cellEdited"].objectAttribute[item])

func saveAttribute():
	var objectAttribute={}
	var objectNodes = references[currents["object"]].get_node("item_container").get_children() 
	for item in objectNodes:
		objectAttribute[str(item.getName())] = item.getValue()
	currents["cellEdited"].objectAttribute = objectAttribute
	currents["sender"].saveAttribute(currents["cellEdited"])
	
func setObjectType(type):
	currents["object"] = type 

func setCellEdited(cell):
	currents["cellEdited"] = cell

func getObjectType():
	return currents["object"]
	
func getObjectAttribute():
	return currents["objectAttribute"]
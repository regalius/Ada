
extends "../abstract_object.gd"

func init(map, cellData):
	defaultAttribute = {
		"lifeTime" : 2,
		"deadTime" : 2,
		"direction": "front",
		"IS_ALIVE": true,
		"teleportPosition" : {"x":0,"y":0,"z":0,"direction": "front"}
	}
	.init(map, cellData)
	self.setType("teleporter")
	
func initReferences():
	.initReferences()
	references["lifeTimeLbl"] = self.get_node("lifetime_lbl")
	
func initCurrents():
	.initCurrents()	
	currents["lifeTime"] = objectAttribute["lifeTime"]
	currents["deadTime"] = objectAttribute["deadTime"]
	currents["teleportPosition"] = objectAttribute["teleportPosition"]
	currents["IS_ALIVE"] = true
	
func interact(actor, nextPos):
	if currents["IS_ALIVE"]:
		print(currents["teleportPosition"])
		actor.setPosition(currents["teleportPosition"], false)
	pass
	
func updateObject():
	if currents["lifeTime"] != -1:
		if currents["IS_ALIVE"]:
			if currents["lifeTime"] > 0:
				self.setLifeTime(currents["lifeTime"]-1)
			else:
				self.setAlive(false)
				self.setDeadTime(objectAttribute["deadTime"])
		elif currents["deadTime"] != -1:
			if currents["deadTime"] > 0:
				self.setDeadTime(currents["deadTime"] -1)
			else:
				self.setAlive(true)
				self.setLifeTime(objectAttribute["lifeTime"])

func resetObject():
	self.setAlive(objectAttribute["IS_ALIVE"])
	self.setLifeTime(objectAttribute["lifeTime"])
	self.setDeadTime(objectAttribute["deadTime"])
	self.setTeleportPosition(objectAttribute["teleportPosition"])
	pass

func setLifeTime(time):
	currents["lifeTime"]=time
	if currents["IS_ALIVE"]:
		if currents["lifeTime"] > -1:
			references["lifeTimeLbl"].set_text(str(currents["lifeTime"]))
		else:
			references["lifeTimeLbl"].set_text(TranslationServer.tr("FOREVER"))
	
func setTeleportPosition(pos):
	currents["teleportPosition"] = pos
	
func setDeadTime(time):
	currents["deadTime"]=time
	if not currents["IS_ALIVE"]:
		if currents["deadTime"] > -1:
			references["lifeTimeLbl"].set_text(str(currents["deadTime"]))
		else:
			references["lifeTimeLbl"].set_text(TranslationServer.tr("FOREVER"))
	
func setAlive(state):
	currents["IS_ALIVE"] = state
	if currents["IS_ALIVE"]:
		self.updateSprite("idle")
	else:
		self.updateSprite("dead")

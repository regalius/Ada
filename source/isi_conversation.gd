
func basic1():
	currents["map"].levelData.tutorial =["grab_piece.move","drop_piece.move.M.1","grab_piece.interact","drop_piece.interact.M.2","play_solver_algorithm"]
	currents["map"].levelData.conversation = [{
							"condition":{"start":1},
							"data":{
									"skipAction":[],
									0:{"text":"CONVERSATION_BASIC1_START0",
										"name":"STRANGE_FLYING_CAT",
										"actor":"lino",
										"emotion":"normal",
										"currentAction":[],
										"nextAction":{1:[["goTo",[1]]]}
									},
									1:{
										"text":"CONVERSATION_BASIC1_START1",
										"name":"Ada",
										"actor":"ada",
										"emotion":"normal",
										"currentAction":[],
										"nextAction":{1:[["goTo",[2]]]}
									},
									2:{
										"text":"CONVERSATION_BASIC1_START2",
										"name":"STRANGE_FLYING_CAT",
										"actor":"lino",
										"emotion":"angry",
										"currentAction":[],
										"nextAction":{1:[["goTo",[3]]]}
									},
									3:{
										"text":"CONVERSATION_BASIC1_START3",
										"name":"Lino",
										"actor":"lino",
										"emotion":"normal",
										"currentAction":[],
										"nextAction":{ 1:[["goTo",[4]]]}
									},
									4:{
										"text":"CONVERSATION_BASIC1_START4",
										"name":"Ada",
										"actor":"ada",
										"emotion":"happy",
										"currentAction":[],
										"nextAction":{1:[["goTo",[5]]]}
									},
									5:{
										"text":"CONVERSATION_BASIC1_START5",
										"name":"Lino",
										"actor":"lino",
										"emotion":"normal",
										"currentAction":[],
										"nextAction":{ 1:[["goTo",[6]]]}
									},
									6:{
										"text":"CONVERSATION_BASIC1_START6",
										"name":"Lino",
										"actor":"lino",
										"emotion":"normal",
										"currentAction":[],
										"nextAction":{ 1:[["goTo",[7]]]}
									},
									7:{
										"text":"CONVERSATION_BASIC1_START7",
										"name":"Lino",
										"actor":"lino",
										"emotion":"normal",
										"currentAction":[["showFocusedItem",[true,"house"]]],
										"nextAction":{ 1:[["showFocusedItem",[false,"house"]],["goTo",[8]]]}
									},
									8:{
										"text":"CONVERSATION_BASIC1_START8",
										"name":"Lino",
										"actor":"lino",
										"emotion":"normal",
										"currentAction":[],
										"nextAction":{ 1:[["goTo",[9]]]}
									},
									9:{
										"text":"CONVERSATION_BASIC1_START9",
										"name":"Lino",
										"actor":"lino",
										"emotion":"normal",
										"currentAction":[["showFocusedItem",[true,"command_bar"]]],
										"nextAction":{ 1:[["showFocusedItem",[false,"command_bar"]],["goTo",[10]]]}
									},
									10:{
										"text":"CONVERSATION_BASIC1_START10",
										"name":"Lino",
										"actor":"lino",
										"emotion":"normal",
										"currentAction":[["showFocusedItem",[true,"function_container_main"]]],
										"nextAction":{ 1:[["showFocusedItem",[false,"function_container_main"]],["goTo",[11]]]}
									},
									11:{
										"text":"CONVERSATION_BASIC1_START11",
										"name":"Lino",
										"actor":"lino",
										"emotion":"normal",
										"currentAction":[["showFocusedItem",[true,"piece_move"]]],
										"nextAction":{ 1:[["showFocusedItem",[false,"piece_move"]],["goTo",[12]]]}
									},
									12:{
										"text":"CONVERSATION_BASIC1_START12",
										"name":"Lino",
										"actor":"lino",
										"emotion":"normal",
										"currentAction":[["showFocusedItem",[true,"piece_interact"]]],
										"nextAction":{ 1:[["showFocusedItem",[false,"piece_interact"]],["goTo",[13]]]}
									},
									13:{
										"text":"CONVERSATION_BASIC1_START13",
										"name":"Lino",
										"actor":"lino",
										"emotion":"normal",
										"currentAction":[["showFocusedItem",[true,"play_btn"]]],
										"nextAction":{ 1:[["showFocusedItem",[false,"play_btn"]],["goTo",[14]]]}
									},
									14:{
										"text":"CONVERSATION_BASIC1_START14",
										"name":"Lino",
										"actor":"lino",
										"emotion":"normal",
										"currentAction":[],
										"nextAction":{ "CONVERSATION_BASIC1_START14_1":[["goTo",[15]]],
														"CONVERSATION_BASIC1_START14_2":[["goTo",[6]]]
													}
									},
									15:{
										"text":"CONVERSATION_BASIC1_START15",
										"name":"Ada",
										"actor":"ada",
										"emotion":"happy",
										"currentAction":[],
										"nextAction":{ 1:[["endConversation",""]]}
									}
							}
						},
						{
							"condition": {"gameover":1},
							"data":{
									"skipAction":[["showResultMenu",[""]]],
									0:{"text":"CONVERSATION_BASIC1_END0",
										"name":"Ada",
										"actor":"ada",
										"emotion":"normal",
										"currentAction":[],
										"nextAction":{1:[["goTo",[1]]]}
									},
									1:{
										"text":"CONVERSATION_BASIC1_END1",
										"name":"Lino",
										"actor":"lino",
										"emotion":"happy",
										"currentAction":[],
										"nextAction":{1:[["goTo",[2]]]}
									},
									2:{
										"text":"CONVERSATION_BASIC1_END2",
										"name":"Ada",
										"actor":"ada",
										"emotion":"happy",
										"currentAction":[],
										"nextAction":{1:[["goTo",[3]]]}
									},
									3:{
										"text":"CONVERSATION_BASIC1_END3",
										"name":"Lino",
										"actor":"lino",
										"emotion":"happy",
										"currentAction":[],
										"nextAction":{1:[["endConversation",""],["showResultMenu",[""]]]}
									}
							}
						}
					]
					
func basic2():
#	currents["map"].levelData.tutorial =["grab_piece.move","drop_piece.move.M.1","grab_piece.interact","drop_piece.interact.M.2","play_solver_algorithm"]
	currents["map"].levelData.conversation = [{
							"condition":{"start":1},
							"data":{
									"skipAction":[],
									0:{"text":"CONVERSATION_BASIC2_START0",
										"name":"Lino",
										"actor":"lino",
										"emotion":"normal",
										"currentAction":[],
										"nextAction":{1:[["goTo",[1]]]}
									},
									1:{
										"text":"CONVERSATION_BASIC2_START1",
										"name":"Lino",
										"actor":"lino",
										"emotion":"normal",
										"currentAction":[["showFocusedItem",[true,"piece_turnLeft"]]],
										"nextAction":{1:[["showFocusedItem",[false,"piece_turnLeft"]],["goTo",[2]]]}
									},
									2:{
										"text":"CONVERSATION_BASIC2_START2",
										"name":"Lino",
										"actor":"lino",
										"emotion":"normal",
										"currentAction":[["showFocusedItem",[true,"piece_turnRight"]]],
										"nextAction":{1:[["showFocusedItem",[false,"piece_turnRight"]],["goTo",[3]]]}
									},
									3:{
										"text":"CONVERSATION_BASIC2_START3",
										"name":"Lino",
										"actor":"lino",
										"emotion":"normal",
										"currentAction":[],
										"nextAction":{ 1:[["goTo",[4]]]}
									},
									4:{
										"text":"CONVERSATION_BASIC2_START4",
										"name":"Ada",
										"actor":"ada",
										"emotion":"normal",
										"currentAction":[],
										"nextAction":{1:[["goTo",[5]]]}
									},
									5:{
										"text":"CONVERSATION_BASIC2_START5",
										"name":"Lino",
										"actor":"lino",
										"emotion":"normal",
										"currentAction":[["showFocusedItem",[true,"rewind_btn"]]],
										"nextAction":{ 1:[["showFocusedItem",[false,"rewind_btn"]],["goTo",[6]]]}
									},
									6:{
										"text":"CONVERSATION_BASIC2_START6",
										"name":"Ada",
										"actor":"ada",
										"emotion":"happy",
										"currentAction":[],
										"nextAction":{ 1:[["goTo",[7]]]}
									},
									7:{
										"text":"CONVERSATION_BASIC2_START7",
										"name":"Lino",
										"actor":"lino",
										"emotion":"normal",
										"currentAction":[],
										"nextAction":{ "CONVERSATION_BASIC2_START7_1":[["goTo",[8]]],
														"CONVERSATION_BASIC2_START7_2":[["goTo",[0]]]
													}
									},
									8:{
										"text":"CONVERSATION_BASIC2_START8",
										"name":"Ada",
										"actor":"ada",
										"emotion":"normal",
										"currentAction":[],
										"nextAction":{ 1:[["goTo",[9]]]}
									},
									9:{
										"text":"CONVERSATION_BASIC2_START9",
										"name":"Ada",
										"actor":"ada",
										"emotion":"normal",
										"currentAction":[],
										"nextAction":{ 1:[["goTo",[10]]]}
									},
									10:{
										"text":"CONVERSATION_BASIC2_START10",
										"name":"Lino",
										"actor":"lino",
										"emotion":"happy",
										"currentAction":[],
										"nextAction":{ 1:[["goTo",[11]]]}
									},
									11:{
										"text":"CONVERSATION_BASIC2_START11",
										"name":"Ada",
										"actor":"ada",
										"emotion":"happy",
										"currentAction":[],
										"nextAction":{ 1:[["endConversation",""]]}
									}
							}
						},
						{
							"condition": {"gameover":1},
							"data":{
									"skipAction":[["showResultMenu",[""]]],
									0:{"text":"CONVERSATION_BASIC2_END0",
										"name":"Ada",
										"actor":"ada",
										"emotion":"happy",
										"currentAction":[],
										"nextAction":{1:[["goTo",[1]]]}
									},
									1:{
										"text":"CONVERSATION_BASIC2_END1",
										"name":"Lino",
										"actor":"lino",
										"emotion":"happy",
										"currentAction":[],
										"nextAction":{1:[["endConversation",""],["showResultMenu",[""]]]}
									},
							}
						}
					]
					
func basic3():
#	currents["map"].levelData.tutorial =["grab_piece.move","drop_piece.move.M.1","grab_piece.interact","drop_piece.interact.M.2","play_solver_algorithm"]
	currents["map"].levelData.conversation = [{
							"condition":{"start":1},
							"data":{
									"skipAction":[],
									0:{"text":"CONVERSATION_BASIC3_START0",
										"name":"Ada",
										"actor":"ada",
										"emotion":"normal",
										"currentAction":[["showFocusedItem",[true,"teleporter"]]],
										"nextAction":{1:[["goTo",[1]]]}
									},
									1:{
										"text":"CONVERSATION_BASIC3_START1",
										"name":"Lino",
										"actor":"lino",
										"emotion":"normal",
										"currentAction":[["showFocusedItem",[true,"teleporter"]]],
										"nextAction":{1:[["goTo",[2]]]}
									},
									2:{
										"text":"CONVERSATION_BASIC3_START2",
										"name":"Ada",
										"actor":"ada",
										"emotion":"normal",
										"currentAction":[],
										"nextAction":{1:[["goTo",[3]]]}
									},
									3:{
										"text":"CONVERSATION_BASIC3_START3",
										"name":"Lino",
										"actor":"lino",
										"emotion":"normal",
										"currentAction":[],
										"nextAction":{ 1:[["goTo",[4]]]}
									},
									4:{
										"text":"CONVERSATION_BASIC3_START4",
										"name":"Ada",
										"actor":"ada",
										"emotion":"normal",
										"currentAction":[],
										"nextAction":{1:[["goTo",[5]]]}
									},
									5:{
										"text":"CONVERSATION_BASIC3_START5",
										"name":"Lino",
										"actor":"lino",
										"emotion":"normal",
										"currentAction":[],
										"nextAction":{ 1:[["goTo",[6]]]}
									},
									6:{
										"text":"CONVERSATION_BASIC3_START6",
										"name":"Ada",
										"actor":"ada",
										"emotion":"angry",
										"currentAction":[],
										"nextAction":{ 1:[["goTo",[7]]]}
									},
									7:{
										"text":"CONVERSATION_BASIC3_START7",
										"name":"Lino",
										"actor":"lino",
										"emotion":"happy",
										"currentAction":[],
										"nextAction":{ 1:[["goTo",[8]]]}
									},
									8:{
										"text":"CONVERSATION_BASIC3_START8",
										"name":"Ada",
										"actor":"ada",
										"emotion":"angry",
										"currentAction":[],
										"nextAction":{ 1:[["goTo",[9]]]}
									},
									9:{
										"text":"CONVERSATION_BASIC3_START9",
										"name":"Lino",
										"actor":"lino",
										"emotion":"happy",
										"currentAction":[],
										"nextAction":{ 1:[["goTo",[10]]]}
									},
									10:{
										"text":"CONVERSATION_BASIC3_START10",
										"name":"Lino",
										"actor":"lino",
										"emotion":"normal",
										"currentAction":[["showFocusedItem",[true,"teleporter_dead"]]],
										"nextAction":{ 1:[["goTo",[11]]]}
									},
									11:{
										"text":"CONVERSATION_BASIC3_START11",
										"name":"Lino",
										"actor":"lino",
										"emotion":"normal",
										"currentAction":[["showFocusedItem",[true,"teleporter"]]],
										"nextAction":{ 1:[["goTo",[12]]]}
									},
									12:{
										"text":"CONVERSATION_BASIC3_START12",
										"name":"Ada",
										"actor":"ada",
										"emotion":"normal",
										"currentAction":[],
										"nextAction":{ 1:[["showFocusedItem",[false,"teleporter"]],["goTo",[13]]]}
									},
									13:{
										"text":"CONVERSATION_BASIC3_START13",
										"name":"Lino",
										"actor":"lino",
										"emotion":"normal",
										"currentAction":[],
										"nextAction":{	"CONVERSATION_BASIC3_START13_1":[["goTo",[14]]],
														"CONVERSATION_BASIC3_START13_2":[["goTo",[1]]]
													}
									},
									14:{
										"text":"CONVERSATION_BASIC3_START14",
										"name":"Ada",
										"actor":"ada",
										"emotion":"happy",
										"currentAction":[],
										"nextAction":{ 1:[["endConversation",""]]}
									}
							}
						},
						{
							"condition": {"gameover":1},
							"data":{
									"skipAction":[["showResultMenu",[""]]],
									0:{"text":"CONVERSATION_BASIC3_END0",
										"name":"Ada",
										"actor":"ada",
										"emotion":"happy",
										"currentAction":[],
										"nextAction":{1:[["goTo",[1]]]}
									},
									1:{
										"text":"CONVERSATION_BASIC3_END1",
										"name":"Lino",
										"actor":"lino",
										"emotion":"happy",
										"currentAction":[],
										"nextAction":{1:[["endConversation",""],["showResultMenu",[""]]]}
									}
							}
						}
					]

func function1():
	currents["map"].levelData.tutorial =["create_new_function","grab_piece.move","drop_piece.move.F1.1",
	"grab_piece.move","drop_piece.move.F1.2","grab_piece.move","drop_piece.move.F1.3",
	"grab_piece.move","drop_piece.move.F1.4","grab_piece.turnRight","drop_piece.turnRight.F1.5",
	"grab_piece.interact","drop_piece.interact.F1.6","grab_piece.turnLeft","drop_piece.turnLeft.F1.7",
	"grab_piece.move","drop_piece.move.F1.8","grab_piece.F1","drop_piece.F1.M.1","grab_piece.turnRight","drop_piece.turnRight.M.2",
	"grab_piece.F1","drop_piece.F1.M.3","grab_piece.turnLeft","drop_piece.turnLeft.M.4",
	"grab_piece.F1","drop_piece.F1.M.5","play_solver_algorithm"]
	currents["map"].levelData.conversation = [{
							"condition":{"start":1},
							"data":{
									"skipAction":[],
									0:{"text":"CONVERSATION_FUNCTION1_START0",
										"name":"Ada",
										"actor":"ada",
										"emotion":"normal",
										"currentAction":[],
										"nextAction":{1:[["goTo",[1]]]}
									},
									1:{
										"text":"CONVERSATION_FUNCTION1_START1",
										"name":"Lino",
										"actor":"lino",
										"emotion":"normal",
										"currentAction":[["showFocusedItem",[true,"function_container_main"]]],
										"nextAction":{1:[["goTo",[2]]]}
									},
									2:{
										"text":"CONVERSATION_FUNCTION1_START2",
										"name":"Ada",
										"actor":"ada",
										"emotion":"normal",
										"currentAction":[],
										"nextAction":{1:[["goTo",[3]]]}
									},
									3:{
										"text":"CONVERSATION_FUNCTION1_START3",
										"name":"Lino",
										"actor":"lino",
										"emotion":"normal",
										"currentAction":[["showFocusedItem",[true,"function_container_function1"]]],
										"nextAction":{ 1:[["goTo",[4]]]}
									},
									4:{
										"text":"CONVERSATION_FUNCTION1_START4",
										"name":"Lino",
										"actor":"lino",
										"emotion":"normal",
										"currentAction":[["showFocusedItem",[true,"newfunction_btn"]]],
										"nextAction":{1:[["goTo",[5]]]}
									},
									5:{
										"text":"CONVERSATION_FUNCTION1_START5",
										"name":"Lino",
										"actor":"lino",
										"emotion":"normal",
										"currentAction":[["showFocusedItem",[true,"piece_F1"]]],
										"nextAction":{ 1:[["goTo",[6]]]}
									},
									6:{
										"text":"CONVERSATION_FUNCTION1_START6",
										"name":"Ada",
										"actor":"ada",
										"emotion":"normal",
										"currentAction":[],
										"nextAction":{ 1:[["goTo",[7]]]}
									},
									7:{
										"text":"CONVERSATION_FUNCTION1_START7",
										"name":"Lino",
										"actor":"lino",
										"emotion":"normal",
										"currentAction":[],
										"nextAction":{ 	"CONVERSATION_FUNCTION1_START7_1":[["endConversation",""]],
														"CONVERSATION_FUNCTION1_START7_2":[["goTo",[1]]]
										}
									}
							}
						},
						{
							"condition": {"gameover":1},
							"data":{
									"skipAction":[["showResultMenu",[""]]],
									0:{"text":"CONVERSATION_FUNCTION1_END0",
										"name":"Ada",
										"actor":"ada",
										"emotion":"happy",
										"currentAction":[],
										"nextAction":{1:[["goTo",[1]]]}
									},
									1:{
										"text":"CONVERSATION_FUNCTION1_END1",
										"name":"Lino",
										"actor":"lino",
										"emotion":"happy",
										"currentAction":[],
										"nextAction":{1:[["endConversation",""],["showResultMenu",[""]]]}
									}
							}
						}
					]

func looping1():
		currents["map"].levelData.tutorial =["create_new_function","grab_piece.move","drop_piece.move.F1.1",
	"grab_piece.turnRight","drop_piece.turnRight.F1.2","grab_piece.interact","drop_piece.interact.F1.3",
	"grab_piece.turnLeft","drop_piece.turnLeft.F1.4","grab_piece.move","drop_piece.move.F1.5","grab_piece.interact","drop_piece.interact.F1.6",
	"grab_piece.F1","drop_piece.F1.F1.7","grab_piece.F1","drop_piece.F1.M.1","play_solver_algorithm"]
	currents["map"].levelData.conversation = [{
							"condition":{"start":1},
							"data":{
									"skipAction":[],
									0:{"text":"CONVERSATION_LOOPING1_START0",
										"name":"Lino",
										"actor":"lino",
										"emotion":"normal",
										"currentAction":[],
										"nextAction":{1:[["goTo",[1]]]}
									},
									1:{
										"text":"CONVERSATION_LOOPING1_START1",
										"name":"Ada",
										"actor":"ada",
										"emotion":"normal",
										"currentAction":[],
										"nextAction":{1:[["goTo",[2]]]}
									},
									2:{
										"text":"CONVERSATION_LOOPING1_START2",
										"name":"Lino",
										"actor":"lino",
										"emotion":"normal",
										"currentAction":[],
										"nextAction":{1:[["endConversation",""]]}
									}
							}
						},
						{
							"condition": {"gameover":1},
							"data":{
									"skipAction":[["showResultMenu",[""]]],
									0:{"text":"CONVERSATION_LOOPING1_END0",
										"name":"Ada",
										"actor":"ada",
										"emotion":"happy",
										"currentAction":[],
										"nextAction":{1:[["endConversation",""],["showResultMenu",[""]]]}
									}
							}
						}
					]
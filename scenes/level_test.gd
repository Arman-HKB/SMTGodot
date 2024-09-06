extends Spatial

#onready var door_2 := $Blocks/LevelBlockDoor2
onready var front_ray := $Player/Collisions/RayCast_Forward
onready var back_ray := $Player/Collisions/RayCast_Backward
onready var left_ray := $Player/Collisions/RayCast_Left
onready var right_ray := $Player/Collisions/RayCast_Right
onready var npcPixie = [$NPC_Pixie.transform.origin.x, $NPC_Pixie.transform.origin.z]
onready var npcJackFrost = [$NPC_JackFrost.transform.origin.x, $NPC_JackFrost.transform.origin.z]
onready var npcPyroJack = [$NPC_PyroJack.transform.origin.x, $NPC_PyroJack.transform.origin.z]
onready var npcNekomata = [$NPC_Nekomata.transform.origin.x, $NPC_Nekomata.transform.origin.z]

func _process(_delta):
	# Pixie
	if front_ray.get_collider() == $Blocks/LevelBlock8:
		$NPC_Pixie.transform.origin.x = npcPixie[0]
		$NPC_Pixie.transform.origin.z = npcPixie[1]
		$NPC_Pixie.transform.origin.z = -2.7
		$NPC_Pixie.show()
	elif back_ray.get_collider() == $Blocks/LevelBlock8:
		$NPC_Pixie.transform.origin.x = npcPixie[0]
		$NPC_Pixie.transform.origin.z = npcPixie[1]
		$NPC_Pixie.transform.origin.z = -1.3
		$NPC_Pixie.show()
	elif left_ray.get_collider() == $Blocks/LevelBlock8:
		$NPC_Pixie.transform.origin.x = npcPixie[0]
		$NPC_Pixie.transform.origin.z = npcPixie[1]
		$NPC_Pixie.transform.origin.x = 0.7
		$NPC_Pixie.show()
	elif right_ray.get_collider() == $Blocks/LevelBlock8:
		$NPC_Pixie.transform.origin.x = npcPixie[0]
		$NPC_Pixie.transform.origin.z = npcPixie[1]
		$NPC_Pixie.transform.origin.x = -0.7
		$NPC_Pixie.show()
	else:
		$NPC_Pixie.hide()

	# Jack Frost
	if front_ray.get_collider() == $Blocks/LevelBlock7 and $Player.get_player_direction() == "NORTH":
		$NPC_JackFrost.transform.origin.x = npcJackFrost[0]
		$NPC_JackFrost.transform.origin.z = npcJackFrost[1]
		$NPC_JackFrost.transform.origin.z = -2.7
		$NPC_JackFrost.show()
	elif back_ray.get_collider() == $Blocks/LevelBlock7 and $Player.get_player_direction() == "SOUTH":
		$NPC_JackFrost.transform.origin.x = npcJackFrost[0]
		$NPC_JackFrost.transform.origin.z = npcJackFrost[1]
		$NPC_JackFrost.transform.origin.z = -1.3
		$NPC_JackFrost.show()
	elif left_ray.get_collider() == $Blocks/LevelBlock7 and $Player.get_player_direction() == "EAST":
		$NPC_JackFrost.transform.origin.x = npcJackFrost[0]
		$NPC_JackFrost.transform.origin.z = npcJackFrost[1]
		$NPC_JackFrost.transform.origin.x = -1.3
		$NPC_JackFrost.show()
	elif right_ray.get_collider() == $Blocks/LevelBlock7 and $Player.get_player_direction() == "WEST":
		$NPC_JackFrost.transform.origin.x = npcJackFrost[0]
		$NPC_JackFrost.transform.origin.z = npcJackFrost[1]
		$NPC_JackFrost.transform.origin.x = -2.7
		$NPC_JackFrost.show()
	else:
		$NPC_JackFrost.hide()
		
	# Nekomata
	if front_ray.get_collider() == $Blocks/LevelBlock9 and $Player.get_player_direction() == "NORTH":
		$NPC_Nekomata.transform.origin.x = npcNekomata[0]
		$NPC_Nekomata.transform.origin.z = npcNekomata[1]
		$NPC_Nekomata.transform.origin.z = -2.7
		$NPC_Nekomata.show()
	elif back_ray.get_collider() == $Blocks/LevelBlock9 and $Player.get_player_direction() == "SOUTH":
		$NPC_Nekomata.transform.origin.x = npcNekomata[0]
		$NPC_Nekomata.transform.origin.z = npcNekomata[1]
		$NPC_Nekomata.transform.origin.z = -1.3
		$NPC_Nekomata.show()
	elif left_ray.get_collider() == $Blocks/LevelBlock9 and $Player.get_player_direction() == "EAST":
		$NPC_Nekomata.transform.origin.x = npcNekomata[0]
		$NPC_Nekomata.transform.origin.z = npcNekomata[1]
		$NPC_Nekomata.transform.origin.x = 2.7
		$NPC_Nekomata.show()
	elif right_ray.get_collider() == $Blocks/LevelBlock9 and $Player.get_player_direction() == "WEST":
		$NPC_Nekomata.transform.origin.x = npcNekomata[0]
		$NPC_Nekomata.transform.origin.z = npcNekomata[1]
		$NPC_Nekomata.transform.origin.x = 1.3
		$NPC_Nekomata.show()
	else:
		$NPC_Nekomata.hide()

	# Pyro Jack
	if back_ray.get_collider() == $Blocks/LevelBlock5 and $Player.get_player_direction() == "NORTH":
		pass
		$NPC_PyroJack.transform.origin.x = npcPyroJack[0]
		$NPC_PyroJack.transform.origin.z = npcPyroJack[1]
		$NPC_PyroJack.transform.origin.z = 1.3
		$NPC_PyroJack.show()
	elif front_ray.get_collider() == $Blocks/LevelBlock5 and $Player.get_player_direction() == "SOUTH":
		$NPC_PyroJack.transform.origin.x = npcPyroJack[0]
		$NPC_PyroJack.transform.origin.z = npcPyroJack[1]
		$NPC_PyroJack.transform.origin.z = 2.7
		$NPC_PyroJack.show()
	elif right_ray.get_collider() == $Blocks/LevelBlock5 and $Player.get_player_direction() == "EAST":
		$NPC_PyroJack.transform.origin.x = npcPyroJack[0]
		$NPC_PyroJack.transform.origin.z = npcPyroJack[1]
		$NPC_PyroJack.transform.origin.x = -1.3
		$NPC_PyroJack.show()
	elif left_ray.get_collider() == $Blocks/LevelBlock5 and $Player.get_player_direction() == "WEST":
		pass
		$NPC_PyroJack.transform.origin.x = npcPyroJack[0]
		$NPC_PyroJack.transform.origin.z = npcPyroJack[1]
		$NPC_PyroJack.transform.origin.x = -2.7
		$NPC_PyroJack.show()
	else:
		$NPC_PyroJack.hide()

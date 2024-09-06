extends Spatial

onready var door_1 := $blocks/LevelBlock3
onready var player := $player

# NPC
onready var npcPixie := $blocks/LevelBlock7/NPC_Pixie
onready var meeting_pixie_dialog
onready var inDialog = false
#onready var cinematicTurnBack = false

# Encounters
onready var encounters = ["res://resources/enemies/pixie.tres", "res://resources/enemies/mermaid.tres", "res://resources/enemies/pele.tres"]

func _ready():
	if State.position:
		player.transform.origin.x = State.position[0][0]
		player.transform.origin.y = State.position[0][1]
		player.transform.origin.z = State.position[0][2]
		player.rotation_degrees.y = State.position[1]

	"""inDialog = true
	var beingWatched = Dialogic.start('BeingWatched')
	add_child(beingWatched)
	beingWatched.connect("timeline_end", self, "cinematic_intro")
	yield(get_tree().create_timer(player.TRAVEL_TIME*5), "timeout")
	inDialog = false
	is_not_in_dialog()"""
	
"""func cinematic_intro(timeline_name):
	if not cinematicTurnBack:
		cinematicTurnBack = true
		Input.action_press("ui_down")
		yield(get_tree().create_timer(player.TRAVEL_TIME*2), "timeout")
		Input.action_release("ui_down")
	#for _i in range(4):
	#	yield(get_tree().create_timer(player.TRAVEL_TIME), "timeout")
	#	player.transform.origin.z += 1
	yield(get_tree().create_timer(player.TRAVEL_TIME), "timeout")
	if cinematicTurnBack:
		for _i in range(2):
			Input.action_press("ui_up")
			yield(get_tree().create_timer(player.TRAVEL_TIME), "timeout")
			Input.action_release("ui_up")
			yield(get_tree().create_timer(player.TRAVEL_TIME), "timeout")
	#yield(get_tree().create_timer(player.TRAVEL_TIME), "timeout")
	is_not_in_dialog()
	inDialog = true
	add_child(meeting_pixie_dialog)
	meeting_pixie_dialog.connect("timeline_end", self, "after_dialog")"""

func before_dialog():
	inDialog = true
func after_dialog(_timeline_name):
	inDialog = false

func _process(_delta):
	#if player.front_ray.get_collider() == door_1 and Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_accept") :
		#yield(get_tree().create_timer(0.2), "timeout")
		#get_tree().change_scene("res://scenes/level_test.tscn")

	# Pixie NPC
	if player.front_ray.get_collider() == npcPixie.get_parent():
		npcPixie.transform.origin.x = 0
		npcPixie.transform.origin.z = 0.7
		npcPixie.show()
		if Input.is_action_pressed("ui_accept") and not inDialog:
			meeting_pixie_dialog = Dialogic.start('MeetingPixie')
			before_dialog()
			add_child(meeting_pixie_dialog)
			meeting_pixie_dialog.connect("timeline_end", self, "after_dialog")
	elif player.back_ray.get_collider() == npcPixie.get_parent():
		npcPixie.transform.origin.x = 0
		npcPixie.transform.origin.z = -0.7
		npcPixie.show()
		if Input.is_action_pressed("ui_accept") and not inDialog:
			meeting_pixie_dialog = Dialogic.start('MeetingPixie')
			before_dialog()
			add_child(meeting_pixie_dialog)
			meeting_pixie_dialog.connect("timeline_end", self, "after_dialog")
	elif player.left_ray.get_collider() == npcPixie.get_parent():
		npcPixie.transform.origin.z = 0
		npcPixie.transform.origin.x = -0.7
		npcPixie.show()
		if Input.is_action_pressed("ui_accept") and not inDialog:
			meeting_pixie_dialog = Dialogic.start('MeetingPixie')
			before_dialog()
			add_child(meeting_pixie_dialog)
			meeting_pixie_dialog.connect("timeline_end", self, "after_dialog")
	elif player.right_ray.get_collider() == npcPixie.get_parent():
		npcPixie.transform.origin.z = 0
		npcPixie.transform.origin.x = 0.7
		npcPixie.show()
		if Input.is_action_pressed("ui_accept") and not inDialog:
			meeting_pixie_dialog = Dialogic.start('MeetingPixie')
			before_dialog()
			add_child(meeting_pixie_dialog)
			meeting_pixie_dialog.connect("timeline_end", self, "after_dialog")
	else:
		if not inDialog:
			npcPixie.hide()

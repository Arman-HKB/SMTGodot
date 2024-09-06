extends Spatial

const TRAVEL_TIME := 0.3

onready var front_ray := $Collisions/RayCast_Forward
onready var back_ray := $Collisions/RayCast_Backward
onready var left_ray := $Collisions/RayCast_Left
onready var right_ray := $Collisions/RayCast_Right
onready var animation := $Animation

var tween

onready var fpsLabel := $UI/FPS
onready var directionLabel := $UI/DirectionRect/Label
var r
var encounterRate

# Steps counter and moon phase
func increment_step():
	State.step += 1
	if State.step > 15:
		State.moonPhase += 1
		State.step = 0
		change_moon_phase()
func change_moon_phase():
	if State.moonPhase == 16:
		State.moonPhase = 0
	match State.moonPhase:
		0:
			$UI/MoonPhaseRect/MoonSprite.frame = 0
		1:
			$UI/MoonPhaseRect/MoonSprite.frame = 1
		2:
			$UI/MoonPhaseRect/MoonSprite.frame = 2
		3:
			$UI/MoonPhaseRect/MoonSprite.frame = 3
		4:
			$UI/MoonPhaseRect/MoonSprite.frame = 4
		5:
			$UI/MoonPhaseRect/MoonSprite.frame = 5
		6:
			$UI/MoonPhaseRect/MoonSprite.frame = 6
		7:
			$UI/MoonPhaseRect/MoonSprite.frame = 7
		8:
			$UI/MoonPhaseRect/MoonSprite.frame = 8
		15:
			$UI/MoonPhaseRect/MoonSprite.frame = 15
		14:
			$UI/MoonPhaseRect/MoonSprite.frame = 14
		13:
			$UI/MoonPhaseRect/MoonSprite.frame = 13
		12:
			$UI/MoonPhaseRect/MoonSprite.frame = 12
		11:
			$UI/MoonPhaseRect/MoonSprite.frame = 11
		10:
			$UI/MoonPhaseRect/MoonSprite.frame = 10
		9:
			$UI/MoonPhaseRect/MoonSprite.frame = 9

func nextBattle():
	r = RandomNumberGenerator.new()
	r.randomize()
	return 1
	#return r.randi_range(6,15)

func check_if_batle():
	change_moon_phase()
	if encounterRate == State.step:
		State.encounter = []
		State.scene = get_player_position()[0]
		State.position = [get_player_position()[1],get_player_position()[2]]
		r = RandomNumberGenerator.new()
		r.randomize()
		var enemy_number = r.randi_range(1,3) # 5
		for _i in range(enemy_number):
			State.encounter.append(get_parent().encounters[r.randi_range(0,get_parent().encounters.size()-1)])
			#print(enemy_number)
		if enemy_number < 5:
			for _i in range(5-enemy_number):
				State.encounter.append(null)
		#State.encounter = [get_parent().encounters[r.randi_range(0,get_parent().encounters.size()-1)], get_parent().encounters[r.randi_range(0,get_parent().encounters.size()-1)],get_parent().encounters[r.randi_range(0,get_parent().encounters.size()-1)],get_parent().encounters[r.randi_range(0,get_parent().encounters.size()-1)], get_parent().encounters[r.randi_range(0,get_parent().encounters.size()-1)]]
		get_tree().change_scene("res://scenes/battle_3d.tscn")

# Player direction
func get_player_direction():
	var camera_node = get_node("Camera")
	if camera_node != null:
		var camera_transform = camera_node.global_transform
		var forward_vector = camera_transform.basis.z.normalized()
		if forward_vector.x > 0.5:
			return "WEST"
		elif forward_vector.x < -0.5:
			return "EAST"
		elif forward_vector.z > 0.5:
			return "NORTH"
		elif forward_vector.z < -0.5:
			return "SOUTH"

func get_player_position():
	return [get_tree().get_current_scene().get_filename(), global_transform.origin, rotation_degrees.y]

func _ready():
	encounterRate = nextBattle()
	change_moon_phase()
	"""$UI/PlayerPanel/HBoxContainer/PlayerData/Container/PlayerName.text = State.name
	$UI/PlayerPanel/HBoxContainer/PlayerData/Container/HP.value = State.current_hp
	$UI/PlayerPanel/HBoxContainer/PlayerData/Container/HP.max_value = State.max_hp
	$UI/PlayerPanel/HBoxContainer/PlayerData/Container/MP.value = State.current_mp
	$UI/PlayerPanel/HBoxContainer/PlayerData/Container/MP.max_value = State.max_mp"""

# Main
func _physics_process(_delta):
	# Show FPS
	fpsLabel.text = "FPS:" + str(Engine.get_frames_per_second())
	directionLabel.text = get_player_direction()
	
	if tween is SceneTreeTween:
		if tween.is_running():
			return
	
	# Move up
	if Input.is_action_pressed("ui_up") and not Input.is_action_pressed("ui_cancel") and not front_ray.is_colliding() and not get_parent().inDialog:
		#tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween = create_tween()
		tween.tween_property(self, "transform", transform.translated(Vector3.FORWARD *2), TRAVEL_TIME)
		yield(get_tree().create_timer(TRAVEL_TIME), "timeout")
		increment_step()
		check_if_batle()
	if Input.is_action_pressed("ui_up") and front_ray.is_colliding() and not get_parent().inDialog:
		animation.play("frontColliding")
		
	# Turn back
	if Input.is_action_pressed("ui_down") and not Input.is_action_pressed("ui_cancel") and not get_parent().inDialog:
		tween = create_tween()
		var player_transform = self.global_transform
		for _i in range(2):
			player_transform.basis = player_transform.basis.rotated(Vector3.UP, -PI / 2)
			tween.tween_property(self, "global_transform", player_transform, TRAVEL_TIME)
		
	# Move back
	if Input.is_action_pressed("ui_down") and Input.is_action_pressed("ui_cancel") and not back_ray.is_colliding() and not get_parent().inDialog:
		tween = create_tween()
		tween.tween_property(self, "transform", transform.translated(Vector3.BACK *2), TRAVEL_TIME)
		yield(get_tree().create_timer(TRAVEL_TIME), "timeout")
		increment_step()
		check_if_batle()
	if Input.is_action_pressed("ui_down") and Input.is_action_pressed("ui_cancel") and back_ray.is_colliding() and not get_parent().inDialog:
		animation.play("backColliding")

	# Straf left
	if Input.is_action_pressed("ui_left_shoulder") and not Input.is_action_pressed("ui_up") and not Input.is_action_pressed("ui_cancel") and not left_ray.is_colliding() and not get_parent().inDialog:
		tween = create_tween()
		tween.tween_property(self, "transform", transform.translated(Vector3.LEFT *2), TRAVEL_TIME/2)
		yield(get_tree().create_timer(TRAVEL_TIME), "timeout")
		increment_step()
		check_if_batle()
	if Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_cancel") and not left_ray.is_colliding() and not get_parent().inDialog:
		tween = create_tween()
		tween.tween_property(self, "transform", transform.translated(Vector3.LEFT *2), TRAVEL_TIME/2)
		yield(get_tree().create_timer(TRAVEL_TIME), "timeout")
		increment_step()
		check_if_batle()
	"""if Input.is_action_pressed("ui_left_shoulder") and Input.is_action_pressed("ui_cancel") and not left_ray.is_colliding() and not get_parent().inDialog:
		tween = create_tween()
		tween.tween_property(self, "transform", transform.translated(Vector3.LEFT *2), TRAVEL_TIME/3.25)
		increment_step()
		check_if_batle()"""
	if Input.is_action_pressed("ui_left_shoulder") or Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_cancel") and left_ray.is_colliding() and not get_parent().inDialog:
		animation.play("leftColliding")
	
	# Straf right
	if Input.is_action_pressed("ui_right_shoulder") and not Input.is_action_pressed("ui_up") and not Input.is_action_pressed("ui_cancel") and not right_ray.is_colliding() and not get_parent().inDialog:
		tween = create_tween()
		tween.tween_property(self, "transform", transform.translated(Vector3.RIGHT *2), TRAVEL_TIME/2)
		yield(get_tree().create_timer(TRAVEL_TIME), "timeout")
		increment_step()
		check_if_batle()
	if Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_cancel") and not right_ray.is_colliding() and not get_parent().inDialog:
		tween = create_tween()
		tween.tween_property(self, "transform", transform.translated(Vector3.RIGHT *2), TRAVEL_TIME/2)
		yield(get_tree().create_timer(TRAVEL_TIME), "timeout")
		increment_step()
		check_if_batle()
	"""if Input.is_action_pressed("ui_right_shoulder") and Input.is_action_pressed("ui_cancel") and not right_ray.is_colliding() and not get_parent().inDialog:
		tween = create_tween()
		tween.tween_property(self, "transform", transform.translated(Vector3.RIGHT *2), TRAVEL_TIME/3.25)
		increment_step()
		check_if_batle()"""
	if Input.is_action_pressed("ui_right_shoulder") or Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_cancel") and right_ray.is_colliding():
		animation.play("rightColliding")
	
	# Turn left
	if Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_cancel") and not get_parent().inDialog:
		tween = create_tween()
		tween.tween_property(self, "transform:basis", transform.basis.rotated(Vector3.UP, PI / 2), TRAVEL_TIME)
		#yield(get_tree().create_timer(TRAVEL_TIME), "timeout")
		#get_player_direction()
	
	# Turn right
	if Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_cancel") and not get_parent().inDialog:
		tween = create_tween()
		tween.tween_property(self, "transform:basis", transform.basis.rotated(Vector3.UP, -PI / 2), TRAVEL_TIME)
		#yield(get_tree().create_timer(TRAVEL_TIME), "timeout")
		#get_player_direction()

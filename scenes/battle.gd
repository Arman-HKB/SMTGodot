extends Control

var resource
var enemy = []
var r

var is_defending
var selected_skill

var order

func _physics_process(_delta):
	$FPS.text = "FPS:" + str(Engine.get_frames_per_second())
	$Order.text = "Order:" + str(order)

"""func min_order():
	var mini
	if State.team[0][7]!="dead": mini=0
	if State.team[0][7]=="dead" && State.team[1][7]!="dead": mini=1
	if State.team[0][7]=="dead" && State.team[1][7]=="dead" && State.team[2][7]!="dead": mini=2
	return mini"""

func _ready():
	$MoonPhaseRect/MoonSprite.frame = State.moonPhase
	is_defending = [false,false,false]
	 #order = min_order()
	order = 0
	
	# HP bars setup
	# Enemies
	var instance
	for path in State.encounter:
		if path != null:
			resource = ResourceLoader.load(path)
			instance = resource.duplicate()
			enemy.append(instance)
		else: enemy.append(null)
	if State.encounter[0] != null:
		$EnemyPanel/EnemyContainerFirst/.show()
		$EnemyPanel/EnemyContainerFirst/Label.text = enemy[0].name
		set_hp($EnemyPanel/EnemyContainerFirst/HP, enemy[0].current_hp, enemy[0].max_hp)
		$EnemyPanel/EnemyContainerFirst/Enemy.texture = enemy[0].texture
	if State.encounter[1] != null:
		$EnemyPanel/EnemyContainerLeft/.show()
		$EnemyPanel/EnemyContainerLeft/Label.text = enemy[1].name
		set_hp($EnemyPanel/EnemyContainerLeft/HP, enemy[1].current_hp, enemy[1].max_hp)
		$EnemyPanel/EnemyContainerLeft/Enemy.texture = enemy[1].texture
	if State.encounter[2] != null:
		$EnemyPanel/EnemyContainerCenter/.show()
		$EnemyPanel/EnemyContainerCenter/Label.text = enemy[2].name
		set_hp($EnemyPanel/EnemyContainerCenter/HP, enemy[2].current_hp, enemy[2].max_hp)
		$EnemyPanel/EnemyContainerCenter/Enemy.texture = enemy[2].texture	
	if State.encounter[3] != null:
		$EnemyPanel/EnemyContainerRight/.show()
		$EnemyPanel/EnemyContainerRight/Label.text = enemy[3].name
		set_hp($EnemyPanel/EnemyContainerRight/HP, enemy[3].current_hp, enemy[3].max_hp)
		$EnemyPanel/EnemyContainerRight/Enemy.texture = enemy[3].texture
	if State.encounter[4] != null:
		$EnemyPanel/EnemyContainerLast/.show()
		$EnemyPanel/EnemyContainerLast/Label.text = enemy[4].name
		set_hp($EnemyPanel/EnemyContainerLast/HP, enemy[4].current_hp, enemy[4].max_hp)
		$EnemyPanel/EnemyContainerLast/Enemy.texture = enemy[4].texture
	# Heroes
	# Party member 1
	if State.team[0][7] == "normal":
		$PlayerPanel/HBoxContainer/PlayerData1/Container/PlayerName.text = State.team[0][0]
		$PlayerPanel/HBoxContainer/PlayerData1/Portrait.texture = load(State.team[0][1])
		set_hp($PlayerPanel/HBoxContainer/PlayerData1/Container/HP, State.team[0][4][2], State.team[0][4][0])
		set_mp($PlayerPanel/HBoxContainer/PlayerData1/Container/MP, State.team[0][4][3], State.team[0][4][1])
	else: $PlayerPanel/HBoxContainer/PlayerData.hide()
	# Party member 2
	if State.team[1][7] == "normal":
		$PlayerPanel/HBoxContainer/PlayerData2/Container/PlayerName.text = State.team[1][0]
		$PlayerPanel/HBoxContainer/PlayerData2/Portrait.texture = load(State.team[1][1])
		set_hp($PlayerPanel/HBoxContainer/PlayerData2/Container/HP, State.team[1][4][2], State.team[1][4][0])
		set_mp($PlayerPanel/HBoxContainer/PlayerData2/Container/MP, State.team[1][4][3], State.team[1][4][1])
	else: $PlayerPanel/HBoxContainer/PlayerData2.hide()
	# Party member 3
	if State.team[2][7] == "normal":
		$PlayerPanel/HBoxContainer/PlayerData3/Container/PlayerName.text = State.team[2][0]
		$PlayerPanel/HBoxContainer/PlayerData3/Portrait.texture = load(State.team[2][1])
		set_hp($PlayerPanel/HBoxContainer/PlayerData3/Container/HP, State.team[2][4][2], State.team[2][4][0])
		set_mp($PlayerPanel/HBoxContainer/PlayerData3/Container/MP, State.team[2][4][3], State.team[2][4][1])
	else: $PlayerPanel/HBoxContainer/PlayerData3.hide()
	update_bars_value()
	
	$Textbox.hide()
	$SkillsPanel.hide()
	$TargetPanel.hide()
	display_actions()

func set_hp(bar, hp, max_hp):
	bar.value = hp
	bar.max_value = max_hp
func set_mp(bar, mp, max_mp):
	bar.value = mp
	bar.max_value = max_mp

func hide_text():
	$Textbox.hide()

func display_text(text):
	if $TargetPanel.is_visible_in_tree(): $TargetPanel.hide()
	if $SkillsPanel.is_visible_in_tree(): $SkillsPanel.hide()
	if $ActionsPanel.is_visible_in_tree(): $ActionsPanel.hide()
	$Textbox/Label.text = text
	$Textbox.show()

func display_actions():
	$ActionsPanel.show()

func _on_Attack_pressed():
	var n
	var type
	#if State.team[order][7] != "dead":
	for i in range(State.team[order][6].size()):
		n = "SkillsPanel/Actions/Skill"+str(i+1)
		if State.team[order][6][i] != null:
			type = State.team[order][6][i][4]
			if type == 0 or type == 1:
				if State.team[order][6][i][5] <= State.team[order][4][2]:
					if !get_node(n).is_visible_in_tree(): get_node(n).show()
					get_node(n).text = State.team[order][6][i][0]
				else: get_node(n).hide()
			else:
				if State.team[order][6][i][5] <= State.team[order][4][3]:
					if !get_node(n).is_visible_in_tree(): get_node(n).show()
					get_node(n).text = State.team[order][6][i][0]
				else: get_node(n).hide()
		else: get_node(n).hide()
	$ActionsPanel.hide()
	$SkillsPanel.show()
	
func _on_Pass_pressed():
	$ActionsPanel.hide()
	is_defending[order] = true
	#if State.team[order][7]!="dead":
	display_text(State.team[order][0]+" prepares to block")
	yield(get_tree().create_timer(0.5), "timeout")
	hide_text()
	order += 1
	check_if_next()

func _on_Run_pressed():
	$ActionsPanel.hide()
	r = RandomNumberGenerator.new()
	r.randomize()
	r = r.randi_range(1, State.team[order][4][8][1]*2)
	if r <= State.team[order][4][8][1]:
		display_text("Escaped")
		yield(get_tree().create_timer(0.5), "timeout")
		hide_text()
		return_from_battle()
	else :
		display_text("Escape failed")
		yield(get_tree().create_timer(0.5), "timeout")
		hide_text()
		enemy_turn()

func return_from_battle():
	if State.dead_members.size() > 0:
		for i in range(State.dead_members.size()): 
			State.dead_members[i][4][2] = 1
			State.team.append(State.dead_members[i])
	State.dead_members = []
	get_tree().change_scene(State.scene)

func check_if_victory():
	var remaining = 5
	for e in enemy:
		if e == null:
			remaining -= 1
	if remaining == 0 : return_from_battle()
	else: check_if_next()
func check_if_defeat():
	#if alive_heroes() == 0:
	if State.team.size() == 0:
		yield(get_tree().create_timer(0.5), "timeout")
		get_tree().quit()

func selectTarget():
	if enemy[0] == null: $TargetPanel/Actions/Target1.hide()
	else: $TargetPanel/Actions/Target1.text = enemy[0].name
	if enemy[1] == null: $TargetPanel/Actions/Target2.hide()
	else: $TargetPanel/Actions/Target2.text = enemy[1].name
	if enemy[2] == null: $TargetPanel/Actions/Target3.hide()
	else: $TargetPanel/Actions/Target3.text = enemy[2].name
	if enemy[3] == null: $TargetPanel/Actions/Target4.hide()
	else: $TargetPanel/Actions/Target4.text = enemy[3].name
	if enemy[4] == null: $TargetPanel/Actions/Target5.hide()
	else: $TargetPanel/Actions/Target5.text = enemy[4].name
	$SkillsPanel.hide()
	$TargetPanel.show()

# Skill selection		
func _on_Skill1_pressed():
	selected_skill = [State.team[order], State.team[order][6][0]]
	selectTarget()
func _on_Skill2_pressed():
	selected_skill = [State.team[order], State.team[order][6][1]]
	selectTarget()
func _on_Skill3_pressed():
	selected_skill = [State.team[order], State.team[order][6][2]]
	selectTarget()
func _on_Skill4_pressed():
	selected_skill = [State.team[order], State.team[order][6][3]]
	selectTarget()
func _on_Skill5_pressed():
	selected_skill = [State.team[order], State.team[order][6][4]]
	selectTarget()

func _on_Target1_pressed():
	order += 1
	attack(selected_skill[0],enemy[0],selected_skill[1], "ally")
func _on_Target2_pressed():
	order += 1
	attack(selected_skill[0],enemy[1],selected_skill[1], "ally")
func _on_Target3_pressed():
	order += 1
	attack(selected_skill[0],enemy[2],selected_skill[1], "ally")
func _on_Target4_pressed():
	order += 1
	attack(selected_skill[0],enemy[3],selected_skill[1], "ally")
func _on_Target5_pressed():
	order += 1
	attack(selected_skill[0],enemy[4],selected_skill[1], "ally")

"""func alive_heroes():
	var a = 0
	for i in range(State.team.size()):
		if State.team[i][7]!="dead": a+=1
	return a"""

func check_if_next():
	#if order < alive_heroes():
	if order < State.team.size():
		$ActionsPanel.show()
	else: enemy_turn()

func enemy_turn():
	#order = min_order()
	order = 0
	var target
	var skill
	for i in range(enemy.size()):
		if enemy[i] != null:
			# Use a random skill
			r = RandomNumberGenerator.new()
			r.randomize()
			r = r.randi_range(0, enemy[i].skills.size()-1)
			skill = enemy[i].skills[r]
			# Target a random hero
			r = RandomNumberGenerator.new()
			r.randomize()
			r = r.randi_range(0, State.team.size()-1)
			"""while State.team[r][7]=="dead":
				r = RandomNumberGenerator.new()
				r.randomize()
				r = r.randi_range(0, State.team.size()-1)"""
			target = State.team[r]
			attack(enemy[i], target, skill, "enemy")
			yield(get_tree().create_timer(1.1), "timeout")
	is_defending = [false, false, false]
	display_actions()

func attack(attacker,target,skill,who):
	$TargetPanel.hide()
	r = RandomNumberGenerator.new()
	r.randomize()
	
	var index
	var ally_index
	if who == "ally":
		index = enemy.find(target,0)
		ally_index = State.team.find(attacker,0)
	else: index = State.team.find(target,0)
	
	# Damage
	var damage = 0
	var type = skill[4]
	var defenseStat
	var attackStat
	if type == 0 or type == 1:
		if who == "ally":
			attacker[4][2] -= skill[5]
			defenseStat = target.vitality
			attackStat = attacker[4][4][1]
		else:
			defenseStat = target[4][6][1]
			attackStat = attacker.strength
	else:
		if who == "ally":
			attacker[4][3] -= skill[5]
			defenseStat = target.magic
			attackStat = attacker[4][5][1]
		else: 
			defenseStat = target[4][5][1]
			attackStat = attacker.magic
	if is_defending[index] && who == "enemy":
		defenseStat = defenseStat*10
		is_defending[index] = false
	
	if who == "ally":
		if index == 0: $EnemyPanel/EnemyContainerFirst/AnimationPlayer.play(skill[6])
		elif index == 1: $EnemyPanel/EnemyContainerLeft/AnimationPlayer.play(skill[6])
		elif index == 2: $EnemyPanel/EnemyContainerCenter/AnimationPlayer.play(skill[6])
		elif index == 3: $EnemyPanel/EnemyContainerRight/AnimationPlayer.play(skill[6])
		else: $EnemyPanel/EnemyContainerLast/AnimationPlayer.play(skill[6])
	else: Global.camera.shake(0.3,15)
	
	if who == "ally":
		if target.weaknesses[type][1] == 1:
			damage = attackStat-defenseStat+r.randi_range(attackStat*13, attackStat*17)
			if damage <= 0: damage = 1
			display_text(attacker[0]+": "+skill[0]+", WEAK! -"+str(damage))
		elif target.weaknesses[type][1] == 2:
			damage = attackStat-defenseStat+r.randi_range(attackStat, attackStat*5)
			if damage <= 0: damage = 1
			display_text(attacker[0]+": "+skill[0]+", RESIST! -"+str(damage))
		else:
			damage = attackStat-defenseStat+r.randi_range(attackStat*8, attackStat*12)
			if damage <= 0: damage = 1
			display_text(attacker[0]+": "+skill[0]+", -"+str(damage))
		target.current_hp = max(0, target.current_hp - damage)
	else:
		if target[5][type][1] == 1:
			damage = attackStat-defenseStat+r.randi_range(attackStat*13, attackStat*17)
			if damage <= 0: damage = 1
			display_text(attacker.name+": "+skill[0]+", WEAK! -"+str(damage))
		elif target[5][type][1] == 2:
			damage = attackStat-defenseStat+r.randi_range(attackStat, attackStat*5)
			if damage <= 0: damage = 1
			display_text(attacker.name+": "+skill[0]+", RESIST! -"+str(damage))
		else:
			damage = attackStat-defenseStat+r.randi_range(attackStat*8, attackStat*12)
			if damage <= 0: damage = 1
			display_text(attacker.name+": "+skill[0]+", -"+str(damage))
		target[4][2] = max(0, target[4][2] - damage)
	
	# Animation
	if who == "ally":
		set_hp(get_node("PlayerPanel/HBoxContainer/PlayerData"+str(ally_index+1)+"/Container/HP"), attacker[4][2], attacker[4][0])
		set_hp(get_node("PlayerPanel/HBoxContainer/PlayerData"+str(ally_index+1)+"/Container/MP"), attacker[4][3], attacker[4][1])
		update_bars_value()
		selected_skill = []
		if index == 0:
			set_hp($EnemyPanel/EnemyContainerFirst/HP, target.current_hp, target.max_hp)
			yield(get_tree().create_timer(0.5), "timeout")
			if target.current_hp <= 0:
				$EnemyPanel/EnemyContainerFirst.hide()
				enemy[index] = null
		elif index == 1:
			set_hp($EnemyPanel/EnemyContainerLeft/HP, target.current_hp, target.max_hp)
			yield(get_tree().create_timer(0.5), "timeout")
			if target.current_hp <= 0:
				$EnemyPanel/EnemyContainerLeft.hide()
				enemy[index] = null
		elif index == 2: 
			set_hp($EnemyPanel/EnemyContainerCenter/HP, target.current_hp, target.max_hp)
			yield(get_tree().create_timer(0.5), "timeout")
			if target.current_hp <= 0:
				enemy[index] = null
				$EnemyPanel/EnemyContainerCenter.hide()
		elif index == 3: 
			set_hp($EnemyPanel/EnemyContainerRight/HP, target.current_hp, target.max_hp)
			yield(get_tree().create_timer(0.5), "timeout")
			if target.current_hp <= 0:
				enemy[index] = null
				$EnemyPanel/EnemyContainerRight.hide()
		else:
			set_hp($EnemyPanel/EnemyContainerLast/HP, target.current_hp, target.max_hp)
			yield(get_tree().create_timer(0.5), "timeout")
			if target.current_hp <= 0:
				enemy[index] = null
				$EnemyPanel/EnemyContainerLast.hide()
		hide_text()
		check_if_victory()
	else:
		set_hp(get_node("PlayerPanel/HBoxContainer/PlayerData"+str(index+1)+"/Container/HP"), State.team[index][4][2], State.team[index][4][0])
		update_bars_value()
		yield(get_tree().create_timer(0.5), "timeout")
		if State.team[index][4][2] <= 0:
			#State.team[index][7] = "dead"
			State.dead_members.append(State.team[index])
			State.team.remove(index)
			get_node("PlayerPanel/HBoxContainer/PlayerData"+str(index+1)).hide()
		hide_text()
		print("target index:"+str(index))
		whos_still_alive()
		check_if_defeat()

func whos_still_alive():
	var a = []
	for i in range(State.team.size()):
		a.append(State.team[i][0])
	print(a)

func update_bars_value():
	for i in range(State.team.size()):
		#if State.team[i]!=null:
		get_node("PlayerPanel/HBoxContainer/PlayerData"+str(i+1)+"/Container/HP/Value").text = str(State.team[i][4][2])+"/"+str(State.team[i][4][0])
		get_node("PlayerPanel/HBoxContainer/PlayerData"+str(i+1)+"/Container/MP/Value").text = str(State.team[i][4][3])+"/"+str(State.team[i][4][1])

func _on_ReturnToActions_pressed():
	$SkillsPanel.hide()
	$ActionsPanel.show()

func _on_ReturnToSkills_pressed():
	$TargetPanel.hide()
	$SkillsPanel.show()

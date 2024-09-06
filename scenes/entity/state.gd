extends Node

# Stat
"""var player_name = "Lancelot"
var portrait = "res://assets/portraits/lancelot.png"
var max_hp = 999
var max_mp = 50
var current_hp = max_hp
var current_mp = max_mp
var strength = 4
var magic = 2
var vitality = 3
var agility = 3
var luck = 4
var currentLevel = 1
var nextLevel = 10"""

# 0:normal/1:weak/2:resist
#var weaknesses = [["Phys", 0],["Pierce", 0],["Fire", 1],["Water", 0],["Elec", 0],["Wind", 0],["Sun", 2],["Moon", 1],["Divine", 0]]

# Skills
# Available : [["Punch", 1, 1, 20, 0, 15], ["Ignis", 1, 1, 30, 2, 4], ["Cataracta", 1, 1, 30, 3, 4], ["Tonitruum", 1, 1, 30, 4, 4], ["Ventus", 1, 1, 30, 5, 4]]
# [Name, 1:Mono/2:All/3:Random, times, Damage, Type [0:Phys, 1:Pierce, 2:Fire, 3:Water, 4:Elec, 5:Wind, 6:Sun, 7:Moon, 8:Divine], cost, animation

# Team
var team = [
	# Name / Portrait / Level / NextLevel / Stats / Weakness / Skill / Status
	# Stat = maxHP, maxMP, HP, MP, [str, mag, vit, agi, luck]
	["Lancelot", "res://assets/portraits/lancelot.png", 1, 10, 
		[100, 30, 50, 30,["str", 4],["mag", 2],["vit", 3],["agi", 3],["luc", 4]], 
		[["Phys", 2],["Pierce", 0],["Fire", 1],["Water", 0],["Elec", 0],["Wind", 0],["Sun", 2],["Moon", 1],["Divine", 0]],
		[["Attack", 1, 1, 20, 0, 0, "Normal"], ["Slash", 1, 1, 40, 0, 25, "Normal"], ["Tonitruum", 1, 1, 30, 4, 4, "Tonitruum"], ["Ventus", 1, 1, 30, 5, 4, "Ventus"], null], "normal"],
	["Medusa", "res://assets/portraits/medusa.png", 1, 7, 
		[80, 50, 50, 50,["str", 2],["mag", 5],["vit", 2],["agi", 3],["luc", 2]], 
		[["Phys", 0],["Pierce", 1],["Fire", 1],["Water", 2],["Elec", 0],["Wind", 0],["Sun", 1],["Moon", 2],["Divine", 0]],
		[["Attack", 1, 1, 20, 0, 0, "Normal"], ["Bite", 1, 1, 25, 1, 10, "Normal"], ["Cataracta", 1, 1, 30, 3, 4, "Cataracta"], null, null], "normal"],
	["Scáthach", "res://assets/portraits/scathach.png", 1, 13, 
		[90, 40, 50, 40,["str", 4],["mag", 4],["vit", 3],["agi", 3],["luc", 3]], 
		[["Phys", 0],["Pierce", 2],["Fire", 2],["Water", 0],["Elec", 1],["Wind", 0],["Sun", 2],["Moon", 2],["Divine", 0]],
		[["Attack", 1, 1, 20, 0, 0, "Normal"], ["Pierce", 1, 1, 30, 1, 20, "Normal"], ["Ignis", 1, 1, 30, 2, 4, "Ignis"], ["Umbra", 1, 1, 30, 7, 8, "Umbra"], null], "normal"],
]

var dead_members = []

# Position before battle
var scene = null
var position = null

# Enemy to fight
var encounter = []

# Step and MoonPhase
var step = 0
var moonPhase = 0

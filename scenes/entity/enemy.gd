extends Resource

export(String) var name = "Demon"
export(Texture) var texture = null
export(int) var max_hp = 10
export(int) var max_mp = 10
export(int) var current_hp = max_hp
export(int) var current_mp = max_mp
export(int) var strength = 2
export(int) var magic = 2
export(int) var vitality = 2
export(int) var agility = 2
export(int) var luck = 2

# 0:normal/1:weak/2:resist
export(Array) var weaknesses = [["Phys", 0],["Pierce", 0],["Fire", 0],["Water", 0],["Elec", 0],["Wind", 0],["Sun", 0],["Moon", 0],["Divine", 0]]

export(Array) var skills = [["Phys", 1, 1, 20, 0, 10],["Magic", 1, 1, 20, 0, 4],["Magic", 1, 1, 20, 0, 4],["Magic", 1, 1, 20, 0, 4],["Magic", 1, 1, 20, 0, 4]]

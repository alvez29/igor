class_name LevelStats

var simple_enemy_health:float
var shooter_enemy_health:float
var enemy_movement_speed:float
var enemy_projectile_speed:float
var enemy_shooting_speed:float
var enemy_projectile_damage:float
var enemy_melee_damage:float
var experience_factor:float
var spawn_enemy_time:float

func _init(simple_enemy_health = float(20), shooter_enemy_health = float(10), enemy_movement_speed = float(300), enemy_projectile_speed = float(500), enemy_shooting_speed = float(1.7), enemy_projectile_damage = float(5), enemy_melee_damage = float(2), experience_factor = float(4), spawn_enemy_time = float(1.2)):
	self.simple_enemy_health = simple_enemy_health
	self.shooter_enemy_health = shooter_enemy_health
	self.enemy_movement_speed = enemy_movement_speed
	self.enemy_projectile_speed = enemy_projectile_speed
	self.enemy_shooting_speed = enemy_shooting_speed
	self.enemy_projectile_damage = enemy_projectile_damage
	self.enemy_melee_damage = enemy_melee_damage
	self.experience_factor = experience_factor
	self.spawn_enemy_time = spawn_enemy_time
	
func copy(simple_enemy_health = self.simple_enemy_health, shooter_enemy_health = self.shooter_enemy_health, enemy_movement_speed = self.enemy_movement_speed, enemy_projectile_speed = self.enemy_projectile_speed, enemy_shooting_speed = self.enemy_shooting_speed, enemy_projectile_damage = self.enemy_projectile_damage, enemy_melee_damage = self.enemy_melee_damage, experience_factor = self.experience_factor, spawn_enemy_time = self.spawn_enemy_time):
	return LevelStats.new(
		simple_enemy_health, 
		shooter_enemy_health, 
		enemy_movement_speed, 
		enemy_projectile_speed, 
		enemy_shooting_speed, 
		enemy_projectile_damage, 
		enemy_melee_damage, 
		experience_factor, 
		spawn_enemy_time
	)

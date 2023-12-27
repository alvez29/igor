class_name RoundStats

var simple_enemy_health:float
var shooter_enemy_health:float
var enemy_movement_speed:float
var enemy_projectile_speed:float
var enemy_shooting_speed:float
var enemy_projectile_damage:float
var enemy_melee_damage:float
var spawn_enemy_time:float
var round_time:int

func _init(simple_enemy_health = float(20), shooter_enemy_health = float(10), enemy_movement_speed = float(300), enemy_projectile_speed = float(500), enemy_shooting_speed = float(1.7), enemy_projectile_damage = float(5), enemy_melee_damage = float(2), spawn_enemy_time = float(0.6), round_time = int(20)):
	self.simple_enemy_health = simple_enemy_health
	self.shooter_enemy_health = shooter_enemy_health
	self.enemy_movement_speed = enemy_movement_speed
	self.enemy_projectile_speed = enemy_projectile_speed
	self.enemy_shooting_speed = enemy_shooting_speed
	self.enemy_projectile_damage = enemy_projectile_damage
	self.enemy_melee_damage = enemy_melee_damage
	self.spawn_enemy_time = spawn_enemy_time
	self.round_time = round_time
	
func copy(simple_enemy_health = self.simple_enemy_health, shooter_enemy_health = self.shooter_enemy_health, enemy_movement_speed = self.enemy_movement_speed, enemy_projectile_speed = self.enemy_projectile_speed, enemy_shooting_speed = self.enemy_shooting_speed, enemy_projectile_damage = self.enemy_projectile_damage, enemy_melee_damage = self.enemy_melee_damage, spawn_enemy_time = self.spawn_enemy_time, round_time = self.round_time):
	return RoundStats.new(
		simple_enemy_health, 
		shooter_enemy_health, 
		enemy_movement_speed, 
		enemy_projectile_speed, 
		enemy_shooting_speed, 
		enemy_projectile_damage, 
		enemy_melee_damage, 
		spawn_enemy_time,
		round_time
	)

static func createRoundOneStats():
	return RoundStats.new()
	
static func createRoundTwoStats():
	return RoundStats.new(float(20), float(10), float(300), float(500), float(1.7), float(5), float(2), float(0.4), int(35))
	

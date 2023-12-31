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
	return RoundStats.new(
		#simple_enemy_health
		float(5),
		#shooter_enemy_health
		float(5),
		#enemy_movement_speed
		float(180),
		#enemy_projectile_speed
		float(350),
		#enemy_shooting_speed
		float(3),
		#enemy_projectile_damage
		float(5),
		#enemy_melee_damage
		float(2),
		#spawn_enemy_time
		float(0.5),
		#round_time
		int(10),
	)
	
static func createRoundTwoStats():
	return RoundStats.new(
		#simple_enemy_health
		float(20),
		#shooter_enemy_health
		float(10),
		#enemy_movement_speed
		float(200),
		#enemy_projectile_speed
		float(500),
		#enemy_shooting_speed
		float(2.5),
		#enemy_projectile_damage
		float(5),
		#enemy_melee_damage
		float(2),
		#spawn_enemy_time
		float(0.4),
		#round_time
		int(15),
	)

static func createRoundThreeStats():
	return RoundStats.new(
		#simple_enemy_health
		float(30),
		#shooter_enemy_health
		float(20),
		#enemy_movement_speed
		float(500),
		#enemy_projectile_speed
		float(600),
		#enemy_shooting_speed
		float(2.25),
		#enemy_projectile_damage
		float(10),
		#enemy_melee_damage
		float(5),
		#spawn_enemy_time
		float(0.3),
		#round_time
		int(20),
	)
	
static func createRoundFourStats():
	return RoundStats.new(
		#simple_enemy_health
		float(30),
		#shooter_enemy_health
		float(20),
		#enemy_movement_speed
		float(500),
		#enemy_projectile_speed
		float(600),
		#enemy_shooting_speed
		float(2),
		#enemy_projectile_damage
		float(10),
		#enemy_melee_damage
		float(5),
		#spawn_enemy_time
		float(0.25),
		#round_time
		int(25),
	)

static func createRoundFiveStats():
	return RoundStats.new(
		#simple_enemy_health
		float(50),
		#shooter_enemy_health
		float(30),
		#enemy_movement_speed
		float(600),
		#enemy_projectile_speed
		float(700),
		#enemy_shooting_speed
		float(2),
		#enemy_projectile_damage
		float(10),
		#enemy_melee_damage
		float(5),
		#spawn_enemy_time
		float(0.2),
		#round_time
		int(25),
	)

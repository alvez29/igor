class_name PlayerStats

var friction:float
var accel:float
var movement_speed:float
var shooting_speed:float
var projectile_speed:float
var damage:float
var health:float
var max_health:float
var player_scale:float
var projectile_scale:float
var experience_factor:float

func _init(
	friction = float(700),
	accel = float(2000), 
	movement_speed = float(700), 
	shooting_speed = float(0.5), 
	projectile_speed = float(700), 
	damage = float(10), 
	health = float(125), 
	max_health = float(125), 
	player_scale = float(1), 
	projectile_scale = float(1), 
	experience_factor = float(4)
	):
	self.friction = friction
	self.accel = accel
	self.movement_speed = movement_speed
	self.shooting_speed = shooting_speed
	self.projectile_speed = projectile_speed
	self.damage = damage
	self.health = health
	self.max_health = max_health
	self.player_scale = player_scale
	self.projectile_scale = projectile_scale
	self.experience_factor = experience_factor

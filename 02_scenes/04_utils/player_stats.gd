class_name PlayerStats

var friction:float
var accel:float
var movement_speed:float
var shooting_speed:float
var projectile_speed:float
var damage:float
var health:float
var max_health:float

func _init(friction = float(1000), accel = float(2000), movement_speed = float(700), shooting_speed = float(0.4), projectile_speed = float(700), damage = float(10), health = float(100), max_health = float(100)):
	self.friction = friction
	self.accel = accel
	self.movement_speed = movement_speed
	self.shooting_speed = shooting_speed
	self.projectile_speed = projectile_speed
	self.damage = damage
	self.health = health
	self.max_health = max_health

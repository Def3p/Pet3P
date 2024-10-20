class_name WeaponManager
extends Node3D

enum states { NONE, IDLE, SHOOT, RELOAD, NO_BULLETS }

@export var weapon_list: Array[PlayerWeapon]

var state: states = states.IDLE
var access_weapon_list: Array[PlayerWeapon]
var start_weapon: PlayerWeapon
var current_weapon: PlayerWeapon
var number_of_weapons: int

@onready var shoot_raycast = $RayCast3D

func _ready():
	pass

func _process(_delta):
	access_weapon_list = []
	for weapon in weapon_list:
		if weapon.access: access_weapon_list.push_back(weapon)
		weapon.hide()

	if len(access_weapon_list) == 0: 
		print("Error 1 'weapon'")
		return

	start_weapon = access_weapon_list[0]
	current_weapon = start_weapon
	number_of_weapons = len(access_weapon_list)

	for weapon in access_weapon_list:
		if current_weapon == weapon: weapon.show()
		else: weapon.hide()

	shoot_raycast.target_position.z = current_weapon.shot_length * -1

func _physics_process(_delta): state_func()

func state_func():
	if state == states.IDLE:
		if Input.is_action_pressed("shoot") and current_weapon != null:
			if current_weapon.total_ammo > 0: state = states.SHOOT
			else: state = states.NO_BULLETS

	elif state == states.SHOOT:
		shoot()

	elif state == states.RELOAD:
		pass
	
	elif state == states.NO_BULLETS:
		pass

func shoot():
	for muzzle in current_weapon.muzzles:
		if current_weapon.total_ammo > 0:
			# shoot line
			if shoot_raycast.get_collider() is HitboxComponent:
				var attack = Attack.new()
				attack.damage = 10
				shoot_raycast.get_collider().damage(attack)

func reload():
	pass

class_name PlayerWeapon
extends Node3D

@export var id: String
@export var muzzles: Array[Marker3D]
@export var max_ammo: int
@export var total_ammo: int
@export var shot_length: float
@export var animator: AnimationPlayer
@export var access: bool = false

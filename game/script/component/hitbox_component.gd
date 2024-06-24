class_name HitboxComponent
extends Area3D

@export var health_component: HealthComponent

func damage(attack: Attack) -> void:
	if health_component: health_component.damage(attack)

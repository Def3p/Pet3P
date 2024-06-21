extends State
class_name PlayerJumpState

@export var player: PlayerMain
@export var camera: Camera3D

func Enter():
	player.velocity.y += player.jump_force
	player.is_falling = true

func Update(delta: float):
	camera.rotation.z = lerp(camera.rotation.z, 0.0, 5 * delta)
	state_transition.emit(self, "FallState")

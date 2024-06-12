extends State
class_name PlayerJumpState

@export var player: PlayerMain
@export var size_animator: AnimationPlayer

func Enter():
	player.velocity.y += player.jump_force
	player.is_falling = true

func Update(_delta: float):
	state_transition.emit(self, "FallState")

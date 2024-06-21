extends State
class_name PlayerFallState

@export var player: PlayerMain
@export var camera: Camera3D

var lerp_speed: float = 25.0
var direction = Vector3.ZERO
var camera_side: int = 0

func Enter(): pass

func Update(delta: float):
	camera_side = Input.get_axis("right", "left")
	camera.rotation.z = lerp(camera.rotation.z, deg_to_rad(2.5 * camera_side) , 5 * delta)
	if player.is_on_floor(): state_transition.emit(self, "IdleState")

	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var to_direction = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	direction = lerp(direction, to_direction, delta * lerp_speed)

	if to_direction:
		player.velocity.x = direction.x * player.current_speed * delta
		player.velocity.z = direction.z * player.current_speed * delta

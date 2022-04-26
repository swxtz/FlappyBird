extends Position2D

onready var timer: Timer = get_node("Timer")

export(float) var spawn_cooldown
export(PackedScene) var pipe_scene

func spawn() -> void:
	var pipe: Pipe = pipe_scene.instance()
	pipe.global_position = random_position()
	var _game_over = connect("game_over", pipe, "game_over")
	add_child(pipe)
	timer.start(spawn_cooldown)



func random_position() -> Vector2:
	randomize()
	var random_number: float = rand_range(-188, 62)
	return Vector2.ZERO


func gamer_over() -> void:
	timer.stop()
	emit_signal("game_over")

func on_Timer_timeout() -> void:
	spawn()

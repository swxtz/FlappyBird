extends KinematicBody2D
class_name Bird

signal game_over

var velocity: Vector2
var can_interact: bool = true 

onready var bird_texture: Sprite = get_node("Texture")
onready var animation: AnimationPlayer = get_node("Animation")


export (Array, String) var texture_list

export(int) var gravity_speed
export(int) var jump_speed

func _ready() -> void:
	set_texture()
	set_physics_process(false)


func set_texture() -> void:
	randomize() 
	var random_number : int = randi() % texture_list.size()
	bird_texture.texture = load(texture_list[random_number])



	# Fisica do jogo  

func _physics_process(delta) -> void:
	velocity.y += gravity_speed * delta
	if velocity.y > gravity_speed:
		velocity.y = gravity_speed


	if Input.is_action_just_pressed("ui_select") and can_interact:
		velocity.y = jump_speed

	velocity = move_and_slide(velocity)

func start() -> void:
	animation.play("idle")
	set_physics_process(true)



func on_body_entered(body: Object) -> void:
	if body.name !="Bird":
		velocity.x = 0 
		can_interact = false
		animation.play("RESET")
		emit_signal("game_over")

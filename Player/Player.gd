extends CharacterBody2D

@export var speed = 300
var sprite
var flip_h = true

func _ready():
	sprite = %PlayerSprite
	
func get_player_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func animate():
	if velocity.x > 0:
		flip_h = false
		sprite.flip_h = flip_h
		sprite.offset = Vector2i(0,0)
		sprite.play("Run")
	elif velocity.x < 0:
		flip_h = true
		sprite.flip_h = flip_h
		sprite.offset = Vector2i(-30,0)
		sprite.play("Run")
	elif velocity.y != 0:
		sprite.play("Run")
	else:
		sprite.play("Idle")

func update_player(delta):
	get_player_input()
	animate()
	move_and_slide()

func _physics_process(delta):
	update_player(delta)

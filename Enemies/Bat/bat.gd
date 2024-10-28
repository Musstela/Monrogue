extends CharacterBody2D

@export var speed = 300
@export var health = 100

@onready var player = get_node("/root/Monrogue/Player")

func _ready():
	%BatAnimations.play("Idle")

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 100.0
	move_and_slide()
	
func take_damage():
	health -= 50
	
	if(health == 0):
		%BatAnimations.play("Death")
		%BatAnimations.animation_finished.connect(queue_free)

extends CharacterBody2D

@export var speed = 300
signal health_depleted 

var health = 100.0
var sprite
var state_machine

func _ready():
	sprite = %PlayerAnimation
	state_machine = %AnimationTree.get("parameters/playback")
	
func get_player_input():
	var current = state_machine.get_current_node()
	velocity = Vector2.ZERO
	
	if Input.is_action_just_pressed("basic_attack"):
		state_machine.travel("basic_attack")
		return
	
	
	if Input.is_action_pressed("right"):
		velocity.x += 1
		%PlayerAnimation.scale.x = 1
		%PlayerAnimation.position.x = 15
		%Basic_Attack.position.x = 50
	if Input.is_action_pressed("left"):
		velocity.x -= 1
		%PlayerAnimation.scale.x = -1
		%PlayerAnimation.position.x = -15
		%Basic_Attack.position.x = -35
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	
	velocity = velocity.normalized() * speed
	animate(velocity)
	
func animate(velocity):
	
	if velocity.length() == 0:
		state_machine.travel("idle")
	if velocity.length() > 0:
		state_machine.travel("run")

func update_player(delta):
	get_player_input()
	move_and_slide()

func _physics_process(delta):
	update_player(delta)
	
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()

	const DAMAGE_RATE = 25
	
	health -= DAMAGE_RATE * overlapping_mobs.size() * delta
	%HealthBar.value = health
	if health <= 0.0:
		health_depleted.emit()

func _on_basic_attack_body_entered(enemy):
	if enemy.has_method("take_damage"):
		enemy.take_damage()

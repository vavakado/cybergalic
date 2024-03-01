extends CharacterBody2D

enum State {Idle, Left, Right}

const SPEED = 100.0
var state := State.Idle
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animation = $AnimatedSprite2D


func change_state(new_state: State):
	state = new_state

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	var Players = get_tree().get_nodes_in_group("player")
	var Player = Players[0]
	
	var to_player_dist_x = abs(self.global_position.x - Player.global_position.x)
	var to_player_dist_y = abs(self.global_position.y - Player.global_position.y)
	
	var to_player_dist = pow(to_player_dist_x*to_player_dist_x + to_player_dist_y*to_player_dist_y, 1.0/2.0)
	#if Player.global_position.x > self.global_position.x:
		#to_player_dist = Player.global_position.x - self.global_position.x
	#elif Player.global_position.x < self.global_position.x:
		#to_player_dist = self.global_position.x - Player.global_position.x
	
	var direction = 0
	
	match state:
		State.Idle:
			direction = 0
		State.Right:
			direction = 1
		State.Left:
			direction = -1
			
	if to_player_dist < 40 and Player.global_position > self.global_position:
		change_state(State.Right)
	elif to_player_dist < 40 and Player.global_position < self.global_position:
		change_state(State.Left)
	else:
		change_state(State.Idle)
		
	if direction == 1:
		velocity.x = direction * SPEED
	elif direction == -1:
		velocity.x = direction * SPEED
	elif direction == 0:
		velocity.x = 0
	
	if direction < 0:
		animation.set_flip_h(true)
	if direction > 0:
		animation.set_flip_h(false)
	if direction == 0:
		animation.play("idle")
	elif direction :
		animation.play("run")
		
	move_and_slide()
	


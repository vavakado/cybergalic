extends Area2D

var vel = Vector2()
var speed = 1000

func _ready():
	await(get_tree().create_timer(5).timeout)
	queue_free()

func _physics_process(delta):
	translate(Vector2(speed,0).rotated(rotation) * delta)


func _on_body_entered(body):
	queue_free()

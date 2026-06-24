extends Area2D

var speed = 300
var direction = Vector2.ZERO

func _process(delta):
	global_position += direction * speed * delta

func _on_body_entered(body):
	if body.name == "player":
		body.die()

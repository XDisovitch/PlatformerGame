extends Node2D

var projectile_scene = preload("res://Projectile.tscn")

func _on_timer_timeout():
	var p = projectile_scene.instantiate()

	get_parent().add_child(p)

	p.global_position = global_position

	var player = get_parent().get_node("player")

	var dir = (player.global_position - global_position).normalized()

	p.direction = dir

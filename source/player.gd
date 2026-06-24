extends CharacterBody2D

const SPEED = 250.0
const JUMP_VELOCITY = -450.0
const GRAVITY = 1000.0

var jumps_left = 2
var dead = false
var keys = 0
var spawn_point = Vector2.ZERO

func _ready():
	spawn_point = position

func _physics_process(delta):
	if dead:
		if Input.is_action_just_pressed("restart"):
			position = spawn_point
			$RespawnSound.play()
			velocity = Vector2.ZERO
			dead = false
			visible = true
		return

	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		jumps_left = 2

	var direction = Input.get_axis("ui_left", "ui_right")

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if Input.is_action_just_pressed("ui_accept") and jumps_left > 0:
		velocity.y = JUMP_VELOCITY
		jumps_left -= 1
		$JumpSound.play()

	move_and_slide()

func _on_spike_body_entered(body):
	if body == self:
		die()

func die():
	dead = true
	$DeathSound.play()
	visible = false

func _on_killzone_body_entered(body: Node2D) -> void:
	if body == self:
		die()

func _on_checkpoint_body_entered(body):
	if body == self:
		spawn_point = position

func _on_trap_body_entered(body: Node2D) -> void:
	if body == self:
		die()


func _on_exit_trigger_body_entered(body: Node2D) -> void:
	if body == self:
		get_tree().change_scene_to_file("res://lvl_2.tscn")



func _on_trap_2_body_entered(body: Node2D) -> void:
	if body == self:
		die()


func _on_exit_trigger_2_body_entered(body: Node2D) -> void:
	if body == self:
		get_tree().change_scene_to_file("res://lvl_3.tscn")


func _on_key_1_body_entered(body: Node2D) -> void:
	if body == self:
		keys += 1
		print("Keys:", keys)
		if keys >= 10:
			var boss = get_parent().get_node_or_null("Boss")

			if boss:
				boss.queue_free()

			$CollisionShape2D.disabled = true


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == self:
		die()


func _on_exit_trigger_final_body_entered(body: Node2D) -> void:
	if body == self:
		get_tree().change_scene_to_file("res://Final.tscn")


func _on_exit_trigger_boss_body_entered(body: Node2D) -> void:
	if body == self:
		get_tree().change_scene_to_file("res://Boss.tscn")


func _on_exit_trigger_reboot_body_entered(body: Node2D) -> void:
	if body == self:
		get_tree().change_scene_to_file("res://lvl_1.tscn")

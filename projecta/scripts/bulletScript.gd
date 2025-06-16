extends CharacterBody2D
var pos:Vector2
var rota:float
var dir:float
var speed = 2000

func _ready():
	global_position = pos
	global_rotation = rota
	
func _physics_process(delta: float) -> void:
	velocity = Vector2(speed,0).rotated(dir)
	move_and_slide()


func _on_hitbox_body_entered(body: Node2D) -> void:
	queue_free()
	pass # Replace with function body.

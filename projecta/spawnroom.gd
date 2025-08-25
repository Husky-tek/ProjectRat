extends Node2D

var lmao = ["res://rooms/phroom3.tscn","res://rooms/phroom2.tscn","res://rooms/phroom1.tscn"]
var rng = RandomNumberGenerator.new()
var numb = rng.randi_range(0,2)
var sroom = lmao[numb]
var room = load(sroom)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var instance = room.instantiate()
	add_child(instance)
	pass # Replace with function body.

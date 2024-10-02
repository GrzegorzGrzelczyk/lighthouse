extends Node

@onready var label: Label =  get_tree().root.get_node("Main/Minigame/MarginContainer/Label")

var souls:int = 0


func _ready() -> void:
	SignalBus.soul_caught.connect(_on_soul_caught)


func _on_soul_caught(soul_points:int) -> void:
	souls += soul_points
	label.text = "Souls: " + str(souls)

extends CanvasLayer

var gamebar := {
	"warmup_length": 20.0,
	"play_area_length": 100.0,
	"total_length": 0.0, # Calculated in _ready
	"cards": {
		"standard": {
			"width": 10.0
		}
	}
}


func _ready() -> void:
	gamebar["total_length"] = gamebar["warmup_length"] + gamebar["play_area_length"]

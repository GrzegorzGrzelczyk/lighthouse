extends CanvasLayer

var gamebar := {
	"warmup_length": 100.0,
	"play_area_length": 400.0,
	"total_length": 0.0, # Calculated in _ready
	"pointer_speed": 100.0, # [px/s]
	"cards": {
		"standard": {
			"width": 10.0
		}
	}
}

@onready var pointer: TextureProgressBar = $MinigameMargin/Pointer
@onready var warmup: NinePatchRect = $MinigameMargin/Warmup
@onready var playpart: NinePatchRect = $MinigameMargin/Playpart


func _ready() -> void:
	gamebar["total_length"] = gamebar["warmup_length"] + gamebar["play_area_length"]
	pointer.max_value = gamebar["total_length"]
	pointer.custom_minimum_size[0] = gamebar["total_length"]
	warmup.custom_minimum_size[0] = gamebar["warmup_length"]
	playpart.custom_minimum_size[0] = gamebar["play_area_length"]


func _physics_process(delta: float) -> void:
	pointer.texture_progress_offset[0] += gamebar["pointer_speed"] * delta
	if pointer.texture_progress_offset[0] >= pointer.max_value: pointer.texture_progress_offset[0] = 0.0

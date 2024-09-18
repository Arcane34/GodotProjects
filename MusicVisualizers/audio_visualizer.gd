extends Control

@onready var spectrum = AudioServer.get_bus_effect_instance(1,0)

@onready var childrenArray = $Visuals.get_children()

const VU_COUNT = 6
const HEIGHT = 1
const FREQ_MAX = 11050.0
#const FREQ_MAX = 1050.0

#const MIN_DB = 60
const MIN_DB = 60





# Get the nodes that represent their corresponding ranges in the audio spectrum
func _ready():
	childrenArray.reverse()
	var temp = []
	for i in childrenArray:
		temp.append(i.get_child(0))
	childrenArray = temp
	

# get the magnitude of the music in specific ranges and set the alpha (transparency) value to this value 
func _process(delta):
	var prev_hz = 0
	
	for i in range(1,VU_COUNT+1):
		var hz = i * FREQ_MAX/ VU_COUNT
		var f = spectrum.get_magnitude_for_frequency_range(prev_hz,hz)
		var energy = clamp((MIN_DB + linear_to_db(f.length()))/ MIN_DB, 0, 1)
		var height = energy * HEIGHT
	
		prev_hz = hz
		
		var middle = childrenArray[i-1]
		print(middle.self_modulate.a)
		var tween = get_tree().create_tween()
		tween.tween_property(middle, "self_modulate:a", height, 0.05)

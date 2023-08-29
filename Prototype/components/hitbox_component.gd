extends Button

@export var health_component : HealthComponent

func _ready():
	self.anchors_preset = PRESET_CENTER_BOTTOM

func damage(attack):
	if health_component:
		health_component.damage(attack)

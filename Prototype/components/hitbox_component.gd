extends Button

@export var health_component : HealthComponent


func damage(card : Ability ):
	if health_component:
		health_component.damage(card)



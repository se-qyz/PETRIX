extends ProgressBar

@onready var label = $Label

func _set_health_bar(health, maxHealth):
	max_value = maxHealth
	value = health
	
	label.text = str(health)
	
func _change_health(newValue):
	value += newValue
	label.text = str(value)

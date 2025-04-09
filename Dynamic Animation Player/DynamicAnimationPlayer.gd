extends Node
class_name DynamicAnimationPlayer

@export var nodes: Dictionary[int, Node]
@export var sound_effects: Dictionary[int, AudioStreamPlayer]
@export var animations: Dictionary[String, DynamicAnimation]
var tween: Tween

func play_key(key: DynamicAnimationKey):
	tween = get_tree().create_tween()
	if key.play_sound_effect:
		var sound_effect: AudioStreamPlayer = sound_effects.get(key.sound_effect_id)
		sound_effect.play()
	tween.tween_property(nodes.get(key.node_id), key.property, key.value.value, key.duration)
	if !key.neasted_mode:
		await tween.finished
	else:
		tween.finished

func play(anime_name: String):
	var animation :DynamicAnimation = animations.get(anime_name)
	for key in animation.keys:
		await play_key(key)

func stop():
	tween.stop()

func pause():
	tween.pause()

func set_speed_scale(speed_scale: int):
	tween.set_speed_scale(speed_scale)

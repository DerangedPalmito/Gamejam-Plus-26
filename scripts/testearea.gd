extends Area2D

signal has_clicked

func _input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		print("Objeto clicado!")
		
		has_clicked.emit()
		_executar_acao_clique()

func _executar_acao_clique() -> void:
	print("Mudando câmera...")

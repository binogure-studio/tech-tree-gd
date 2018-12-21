extends Control

func initialize(node_data):
  var disabled = node_data.disabled
  var activated = not node_data.disabled

  if node_data.parent != null:
    disabled = node_data.parent.disabled

  # Update button state
  set_disabled(disabled)

  if node_data.has('mask'):
    set_click_mask(node_data.mask)

  if node_data.textures.has('disabled'):
    set_disabled_texture(node_data.textures.disabled)

  if node_data.textures.has('focused'):
    set_focused_texture(node_data.textures.focused)

  if node_data.textures.has('hover'):
    set_hover_texture(node_data.textures.hover)

  if node_data.textures.has('normal'):
    set_normal_texture(node_data.textures.normal)

  if activated and node_data.textures.has('activated'):
    set_normal_texture(node_data.textures.activated)

  if node_data.textures.has('pressed'):
    set_pressed_texture(node_data.textures.pressed)

  var tooltip = node_data.tooltip.enabled

  if is_disabled():
    tooltip = node_data.tooltip.disabled

  set_tooltip(tooltip)

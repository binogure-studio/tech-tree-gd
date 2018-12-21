extends Control

export(int, 1, 20) var nb_points_to_create = 12
export(int, 2, 7) var nb_root_to_create = 6

export(Color) var line_color_enabled = Color()
export(Color) var line_color_disabled = Color()
export(int, 1, 24) var line_width = 1.0

const uuid = preload('res://example/uuid.gd')
const icon = preload('res://assets/icon.png')
const icon_disabled = preload('res://assets/icon-disabled.png')
const icon_activated = preload('res://assets/icon-activated.png')

onready var techtree_node = get_node('techtree')

func _ready():
  techtree_node.connect('button_pressed', self, 'button_pressed')
  initialize()

func button_pressed(node_data):
  node_data.disabled = false

  techtree_node.button_updated(node_data)

func set_nb_points_to_create(value):
  nb_points_to_create = value
  initialize()

func set_nb_root_to_create(value):
  nb_root_to_create = value
  initialize()

func initialize():
  var points_to_create = []

  for root_index in range(0, nb_root_to_create):
    var previous_point = create_point()

    points_to_create.append(previous_point)

    for node_index in range(0, nb_points_to_create):
      var point = null

      randomize()
      if (randi() % 8) == 1:
        previous_point = create_point(previous_point)
        point = previous_point
      else:
        point = create_point(previous_point)

      randomize()
      if (randi() % 5) == 1:
        point.disabled = true

      points_to_create.append(point)

  techtree_node.initialize(points_to_create, nb_root_to_create)

func create_point(parent = null):
  var disabled = false

  if parent != null:
    disabled = parent.disabled

  var node = {
    id = uuid.v4(),
    root = (parent == null),
    parent = parent,
    disabled = disabled,
    textures = {
      normal = icon,
      disabled = icon_disabled,
      activated = icon_activated
    },
    tooltip = {
      enabled = 'enabled',
      disabled = 'disabled'
    },
    metadata = {},
    line = {
      color = {
        enabled = line_color_enabled,
        disabled = line_color_disabled
      },
      width = line_width
    }
  }

  return node

# -*- coding: utf-8 -*-
#==============================================================================
# ** Window_BattleStatus
#------------------------------------------------------------------------------
#  This window is for displaying the status of party members on the battle
# screen.
#==============================================================================

class Window_BattleStatus < Window_Selectable
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  def initialize
    super(0, 0, window_width, window_height)
    refresh
    self.openness = 0
  end
  #--------------------------------------------------------------------------
  # * Get Window Width
  #--------------------------------------------------------------------------
  def window_width
    Graphics.width - 128
  end
  #--------------------------------------------------------------------------
  # * Get Window Height
  #--------------------------------------------------------------------------
  def window_height
    fitting_height(visible_line_number)
  end
  #--------------------------------------------------------------------------
  # * Get Number of Lines to Show
  #--------------------------------------------------------------------------
  def visible_line_number
    return 6
  end
  #--------------------------------------------------------------------------
  # * Get Number of Items
  #--------------------------------------------------------------------------
  def item_max
    $game_party.battle_members.size
  end
  #--------------------------------------------------------------------------
  # * Refresh
  #--------------------------------------------------------------------------
  def refresh
    contents.clear
    draw_all_items
  end
  #--------------------------------------------------------------------------
  # * Draw Item
  #--------------------------------------------------------------------------
  def draw_item(index)
    actor = $game_party.battle_members[index]
    draw_basic_area(basic_area_rect(index), actor)
    draw_gauge_area(gauge_area_rect(index), actor)
  end
  #--------------------------------------------------------------------------
  # * Get Basic Area Retangle
  #--------------------------------------------------------------------------
  def basic_area_rect(index)
    rect = Rect.new
    rect.x = window_width / 4 * index
    rect.y = 0
    rect.width = window_width / 4
    rect.height = window_height
    rect
  end
  #--------------------------------------------------------------------------
  # * Get Gauge Area Rectangle
  #--------------------------------------------------------------------------
  def gauge_area_rect(index)
    rect = basic_area_rect(index)
    rect.x += 4
    rect.y += 82
    rect.width -= 16
    rect.height -= 100
    rect
  end
  #--------------------------------------------------------------------------
  # * Get Gauge Area Width
  #--------------------------------------------------------------------------
  def gauge_area_width
    return 220
  end
  #--------------------------------------------------------------------------
  # * Draw Basic Area
  #--------------------------------------------------------------------------
  def draw_basic_area(rect, actor)
    prev_face_index = actor.face_index
    if actor.is_dead?
      actor.set_face_index(actor.face_index - 1)
    elsif actor.is_critical?
      actor.set_face_index(actor.face_index - 1)
    else
      actor.set_face_index(actor.face_index)
    end
    draw_actor_face(actor, rect.x + 2, rect.y + 2)
    # draw_actor_name(actor, rect.x + 4, rect.y + 2, 100)
    actor.set_face_index(prev_face_index)
  end
  #--------------------------------------------------------------------------
  # * Draw Gauge Area
  #--------------------------------------------------------------------------
  def draw_gauge_area(rect, actor)
    contents.font.size = 18
    if $data_system.opt_display_tp
      draw_gauge_area_with_tp(rect, actor)
    else
      draw_gauge_area_without_tp(rect, actor)
    end
    draw_actor_icons(actor, rect.x, rect.y + 48, rect.width)
    draw_emotions_values(rect, actor)
    reset_font_settings
  end
  #--------------------------------------------------------------------------
  # * Draw Gauge Area (with TP)
  #--------------------------------------------------------------------------
  def draw_gauge_area_with_tp(rect, actor)
    draw_actor_hp(actor, rect.x, rect.y, rect.width)
    draw_actor_mp(actor, rect.x, rect.y + 16, rect.width)
    draw_actor_tp(actor, rect.x, rect.y + 32, rect.width)
  end
  #--------------------------------------------------------------------------
  # * Draw Gauge Area (without TP)
  #--------------------------------------------------------------------------
  def draw_gauge_area_without_tp(rect, actor)
    draw_actor_hp(actor, rect.x, rect.y, rect.width)
    draw_actor_mp(actor, rect.x, rect.y + 16, rect.width)
  end
  #--------------------------------------------------------------------------
  # * Actor Emotion Values
  #--------------------------------------------------------------------------
  def draw_emotions_values(rect, actor)
    contents.font.size = 18
    contents.font.color = Color.new(46, 204, 64)
    if actor.happiness > 0
      draw_icon_with_size(528, rect.x, rect.y + 42, 18)
    else
      draw_icon_with_size(528 + 3, rect.x, rect.y + 42, 18)
    end
    if actor.courage > 0
      draw_icon_with_size(529, rect.x + rect.width / 3, rect.y + 42, 18)
    else
      draw_icon_with_size(529 + 3, rect.x + rect.width / 3, rect.y + 42, 18)
    end
    if actor.confidence > 0
      draw_icon_with_size(530, rect.x + rect.width / 3 * 2, rect.y + 42, 18)
    else
      draw_icon_with_size(530 + 3, rect.x + rect.width / 3 * 2, rect.y + 42, 18)
    end
    draw_emotion_number_value(rect.x + 20, rect.y + 3, actor.happiness)
    draw_emotion_number_value(rect.x + rect.width / 3 + 20, rect.y + 3, actor.courage)
    draw_emotion_number_value(rect.x + rect.width / 3 * 2 + 20, rect.y + 3, actor.confidence)
  end
  #--------------------------------------------------------------------------
  # * Actor Emotion Number Values
  #--------------------------------------------------------------------------
  def draw_emotion_number_value(x, y, value)
    # Draw the text values
    if value == 0
      contents.font.color = Color.new(170, 170, 170)
    elsif value > 0
      contents.font.color = Color.new(46, 204, 64)
    else
      contents.font.color = Color.new(255, 65, 54)
    end
    draw_text(x, y, 100, 100, value.abs)
  end
  #--------------------------------------------------------------------------
  # * Update Cursor
  #--------------------------------------------------------------------------
  def update_cursor
    if @cursor_all
      cursor_rect.set(basic_area_rect(@index))
      cursor_rect.width -= 8
      cursor_rect.height -= 24
      self.top_row = 0
    elsif @index < 0
      cursor_rect.empty
    else
      ensure_cursor_visible
      cursor_rect.set(basic_area_rect(@index))
      cursor_rect.width -= 8
      cursor_rect.height -= 24
    end
  end
end

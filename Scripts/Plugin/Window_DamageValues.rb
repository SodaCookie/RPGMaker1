class Window_DamageValues < Window_Base

  def initialize
    super(0, 0, Graphics.width, Graphics.height)
    @damage_values = []
    @damage_color = Color.new(255, 65, 54)
  end

  def add_damage_text(x, y, amount, offset)
    @damage_values.add({:x => x, :y => y, :amount => amount, :offset => -offset})
  end

  def duration
    60.0
  end

  def vertical_velocity
    1
  end

  def horizontal_velocity
    0
  end

  def update
    super
    update_damage_values
  end

  def update_damage_values
    contents.clear
    @damage_values.delete_if do |damage_text|
      if damage_text[:offset] >= 0
        t = damage[:offset] / duration
        draw_damage_text(
          damage_text[:x] + t * horizontal_velocity,
          damage_text[:y] + t * vertical_velocity,
          damage_text[:amount],
          Color.new(@damage_color.red * t, @damage_color.green * t, @damage_color.blue * t, 255 * t)
        )
      end
      damage_text[:offset] += 1
      damage_text[:offset] >= duration
    end
  end

  def draw_damage_text(x, y, amount, color)
    contents.font.color = color
    contents.font.size = 30
    draw_text(x, y, 100, 30, amount)
    reset_font_settings
  end
end

class Sprite_DamageValues < Sprite

  def initialize
    super
    self.bitmap = Bitmap.new(Graphics.width, Graphics.height)
    @damage_color = Color.new(255, 65, 54)
    self.bitmap.font.size = 50
    self.z = 1000
    @damage_values = []
  end

  def dispose
    super
    self.bitmap.dispose
  end

  def add_damage_text(x, y, amount, offset)
    @damage_values.push({:x => x, :y => y, :amount => amount, :offset => -offset})
  end

  def duration
    60.0
  end

  def vertical_distance
    -40
  end

  def horizontal_distance
    0
  end

  def update
    super
    update_damage_values
  end

  def update_damage_values
    self.bitmap.clear
    @damage_values.delete_if do |damage_text|
      if damage_text[:offset] >= 0
        t = damage_text[:offset] / duration - 1
        t = t*t*t + 1
        draw_damage_text(
          damage_text[:x] + t * horizontal_distance,
          damage_text[:y] + t * vertical_distance,
          damage_text[:amount],
          Color.new(@damage_color.red * (1 - t), @damage_color.green * (1 - t), @damage_color.blue * (1 - t), 255 * (1 - t))
        )
      end
      damage_text[:offset] += 1
      damage_text[:offset] >= duration
    end
  end

  def draw_damage_text(x, y, amount, color)
    # self.bitmap.fill_rect(self.bitmap.rect, Color.new(0,0 ,0))
    text_rect = self.bitmap.text_size(amount)
    self.bitmap.font.color = color
    self.bitmap.draw_text(x - text_rect.width / 2, y - text_rect.height / 2, 100, 30, amount)
  end
end

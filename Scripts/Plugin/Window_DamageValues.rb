class Sprite_DamageValues < Sprite

  def initialize
    super
    self.bitmap = Bitmap.new(Graphics.width, Graphics.height)
    @damage_color = Color.new(255, 65, 54)
    @critical_color = Color.new(255, 255, 0)
    self.z = 1000
    @damage_values = []
  end

  def dispose
    super
    self.bitmap.dispose
  end

  def add_damage_text(x, y, amount, offset)
    add_text(x, y, amount, offset, @damage_color, 50)
  end

  def add_critical_text(x, y, amount, offset)
    add_text(x, y, amount, offset, @critical_color, 80)
  end

  def add_status_text(x, y, text, offset, color=Color.new(255, 255, 255))
    add_text(x, y, text, offset, color, 40)
  end

  def add_text(x, y, amount, offset, colour, size)
    @damage_values.push({
      :x => x + (Kernel.rand(20) - 10),
      :y => y - (Kernel.rand(20) - 10),
      :amount => amount,
      :offset => -offset,
      :direction => direction,
      :colour => colour,
      :size => size
    })
  end

  def duration
    60.0
  end

  def distance
    40
  end

  def direction
    angle = (Kernel.rand(20) - 10 + 90) * Math::PI / 180
    [Math.cos(angle) , -Math.sin(angle)]
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
          damage_text[:x] + t * distance * damage_text[:direction][0],
          damage_text[:y] + t * distance * damage_text[:direction][1],
          damage_text[:amount],
          Color.new(damage_text[:colour].red * (1 - t), damage_text[:colour].green * (1 - t), damage_text[:colour].blue * (1 - t), 255 * (1 - t)),
          damage_text[:size]
        )
      end
      damage_text[:offset] += 1
      damage_text[:offset] >= duration
    end
  end

  def draw_damage_text(x, y, amount, color, size)
    # self.bitmap.fill_rect(self.bitmap.rect, Color.new(0,0 ,0))
    self.bitmap.font.color = color
    self.bitmap.font.size = size
    text_rect = self.bitmap.text_size(amount)
    self.bitmap.draw_text(x - text_rect.width / 2, y - text_rect.height / 2, text_rect.width, text_rect.height, amount)
  end
end

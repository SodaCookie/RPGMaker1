class Game_ClassAttribute

  attr_reader :main_id
  attr_reader :second_id

  def initialize(main_id, second_id)
    @main_id = main_id
    @second_id = second_id
  end

end

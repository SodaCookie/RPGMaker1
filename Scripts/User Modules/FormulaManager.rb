module FormulaManager

  def self.begin_basic(subject, target, damage=0, count=0)
    $game_variables[0] = subject
    $game_variables[1] = target
    $game_variables[2] = damage
    $game_variables[3] = count
    damage
  end
end

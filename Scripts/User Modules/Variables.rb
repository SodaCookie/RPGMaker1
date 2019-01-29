module Variables

  ClassSkills = {
    1 => Game_ClassSkills.new(128, 2),
    2 => Game_ClassSkills.new(2, 1),
    3 => Game_ClassSkills.new(1, 2),
    4 => Game_ClassSkills.new(1, 2),
    5 => Game_ClassSkills.new(1, 2),
    6 => Game_ClassSkills.new(1, 2),
    7 => Game_ClassSkills.new(1, 2),
    8 => Game_ClassSkills.new(1, 2),
    9 => Game_ClassSkills.new(129, 130),
    10 => Game_ClassSkills.new(1, 2),
  }

  ActorDefaultEmotionValues = {
    1 => {:happiness => -25, :courage => -10, :confidence => -10},
    2 => {:happiness => -20, :courage => -35, :confidence => -20},
    3 => {:happiness => -10, :courage => -10, :confidence => -25},
    4 => {:happiness => 30, :courage => -10, :confidence => -10}
  }

  ActorDefaultBattleCallbacks = {
    1 => {},
    2 => {},
    3 => {},
    4 => {}
  }

end

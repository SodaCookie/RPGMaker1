class Game_EmotionActor < Game_Actor

  attr_reader   :happiness
  attr_reader   :confidence
  attr_reader   :courage

  def initialize(actor_id)
    super(actor_id)
    @happiness = -9
    @confidence = 0
    @courage  = 9
  end
  #--------------------------------------------------------------------------
  # * Add stat overrides here based on confidence
  #--------------------------------------------------------------------------

  def is_critical?
    return hp < mhp / 4 || happiness < 0 || confidence < 0 || courage < 0
  end

  def is_dead?
    return hp == 0
  end

end

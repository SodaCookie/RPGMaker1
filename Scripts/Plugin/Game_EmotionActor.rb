class Game_EmotionActor < Game_Actor
  def initialize(actor_id)
    super(actor_id)
    @happiness = -90
    @courage  = 90
    @confidence = 0
  end
  #--------------------------------------------------------------------------
  # * Add stat overrides here based on confidence
  #--------------------------------------------------------------------------
  def happiness=(value)
    @happiness = [-90, [value, 90].min].max
  end

  def happiness
    @happiness / 10
  end

  def courage=(value)
    @courage = [-90, [value, 90].min].max
  end

  def courage
    @courage / 10
  end

  def confidence=(value)
    @confidence = [-90, [value, 90].min].max
  end

  def confidence
    @confidence / 10
  end

  def is_critical?
    return hp < mhp / 4 || happiness < 0 || confidence < 0 || courage < 0
  end

  def is_dead?
    return hp == 0
  end
end

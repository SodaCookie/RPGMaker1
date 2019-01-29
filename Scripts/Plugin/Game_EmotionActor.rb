class Game_EmotionActor < Game_Actor
  def initialize(actor_id)
    super(actor_id)
    setup_actor
    setup_battle_callbacks
    @default_face_name = @face_name
    @default_face_index = self.face_index
  end

  def setup_actor
    @happiness = Variables::ActorDefaultEmotionValues[@actor_id][:happiness]
    @courage  = Variables::ActorDefaultEmotionValues[@actor_id][:courage]
    @confidence = Variables::ActorDefaultEmotionValues[@actor_id][:confidence]
    @default_happiness = @happiness
    @default_courage  = @courage
    @default_confidence = @confidence
    @remark = nil
  end
  #--------------------------------------------------------------------------
  # * Setting face settings based on KH setup
  #--------------------------------------------------------------------------
  def set_face_neutral
    @face_name = @default_face_name
    @face_index = @default_face_index
  end

  def set_face_happy
    @face_name = "%s_0%d" % [@default_face_name, @default_face_index / 2 + 1]
    @face_index = (@default_face_index % 2) * 2 + 5
  end

  def set_face_very_happy
    @face_name = "%s_0%d" % [@default_face_name, @default_face_index / 2 + 1]
    @face_index = (@default_face_index % 2) * 2
  end

  def set_face_angry
    @face_name = "%s_0%d" % [@default_face_name, @default_face_index / 2 + 1]
    @face_index = (@default_face_index % 2) * 2 + 1
  end

  def set_face_sad
    @face_name = "%s_0%d" % [@default_face_name, @default_face_index / 2 + 1]
    @face_index = (@default_face_index % 2) * 2 + 4
  end
  #--------------------------------------------------------------------------
  # * methods for callback that affect emotion status
  #--------------------------------------------------------------------------
  def set_remark(text)
    @remark = text
  end

  def clear_remark
    @remark = nil
  end
  #--------------------------------------------------------------------------
  # * Method overrides
  #--------------------------------------------------------------------------
  def execute_damage(user)
    previous_critical_state = critical?
    super(user)
    if is_critical? != previous_critical_state
      on_self_critical_state
      $game_party.battle_members.each do |actor|
        if !equal?(actor)
          actor.on_ally_critical_state
        end
      end
    end
  end

  def on_damage(value)
    super
    if @result.critical
      on_self_critical_hit
      $game_party.battle_members.each do |actor|
        if !equal?(actor)
          actor.on_ally_critical_hit
        end
      end
    else
      on_self_hit
      $game_party.battle_members.each do |actor|
        if !equal?(actor)
          actor.on_ally_hit
        end
      end
  end

  def add_state(state_id)
    super(state_id)
    if state_id == death_state_id
      on_self_knocked_out
      $game_party.battle_members.each do |actor|
        if !equal?(actor)
          actor.on_ally_knocked_out
        end
      end
    end
  end
  #--------------------------------------------------------------------------
  # * methods for callback that affect emotion status
  #--------------------------------------------------------------------------
  def setup_battle_callbacks
    @default_battle_callbacks = {
      :on_escape => nil,
      :on_victory => nil,
      :on_battle_start => nil,
      :on_turn_end => nil,
      :on_self_hit => nil,
      :on_self_critical_state => nil,
      :on_self_critical_hit => nil,
      :on_self_knocked_out => nil,
      :on_ally_hit => nil,
      :on_ally_critical_state => nil,
      :on_ally_critical_hit => nil,
      :on_ally_knocked_out => nil,
      :on_miss => nil,
      :on_no_damage => nil,
      :on_critical_hit => nil,
      :on_killing_blow => nil
    }
    @default_battle_callbacks.merge!(Variables::ActorDefaultBattleCallbacks[@actor_id])
  end

  def on_escape
    if @default_battle_callbacks.key?(:on_escape)
      @default_battle_callbacks[:on_escape](self)
    end
    if @battle_remarks.key?
      # Add remark handling here
    end
  end

  def on_victory
    if @default_battle_callbacks.key?(:on_victory)
      @default_battle_callbacks[:on_victory](self)
    end
    if @battle_remarks.key?
      # Add remark handling here
    end
  end

  def on_battle_start
    if @default_battle_callbacks.key?(:on_battle_start)
      @default_battle_callbacks[:on_battle_start](self)
    end
    if @battle_remarks.key?
      # Add remark handling here
    end
  end

  def on_turn_end
    super
    if @default_battle_callbacks.key?(:on_turn_end)
      @default_battle_callbacks[:on_turn_end](self)
    end
    if @battle_remarks.key?
      # Add remark handling here
    end
  end

  def on_self_hit
    if @default_battle_callbacks.key?(:on_self_hit)
      @default_battle_callbacks[:on_self_hit](self)
    end
    if @battle_remarks.key?
      # Add remark handling here
    end
  end

  def on_self_critical_state
    if @default_battle_callbacks.key?(:on_self_critical_state)
      @default_battle_callbacks[:on_self_critical_state](self)
    end
    if @battle_remarks.key?
      # Add remark handling here
    end
  end

  def on_self_critical_hit
    if @default_battle_callbacks.key?(:on_self_critical_hit)
      @default_battle_callbacks[:on_self_critical_hit](self)
    end
    if @battle_remarks.key?
      # Add remark handling here
    end
  end

  def on_self_knocked_out
    if @default_battle_callbacks.key?(:on_self_knocked_out)
      @default_battle_callbacks[:on_self_knocked_out](self)
    end
    if @battle_remarks.key?
      # Add remark handling here
    end
  end

  def on_ally_hit
    if @default_battle_callbacks.key?(:on_ally_hit)
      @default_battle_callbacks[:on_ally_hit](self)
    end
    if @battle_remarks.key?
      # Add remark handling here
    end
  end

  def on_ally_critical_state
    if @default_battle_callbacks.key?(:on_ally_critical_state)
      @default_battle_callbacks[:on_ally_critical_state](self)
    end
    if @battle_remarks.key?
      # Add remark handling here
    end
  end

  def on_ally_critical_hit
    if @default_battle_callbacks.key?(:on_ally_critical_hit)
      @default_battle_callbacks[:on_ally_critical_hit](self)
    end
    if @battle_remarks.key?
      # Add remark handling here
    end
  end

  def on_ally_knocked_out
    if @default_battle_callbacks.key?(:on_ally_knocked_out)
      @default_battle_callbacks[:on_ally_knocked_out](self)
    end
    if @battle_remarks.key?
      # Add remark handling here
    end
  end

  def on_miss
    if @default_battle_callbacks.key?(:on_miss)
      @default_battle_callbacks[:on_miss](self)
    end
    if @battle_remarks.key?
      # Add remark handling here
    end
  end

  def on_no_damage
    if @default_battle_callbacks.key?(:on_no_damage)
      @default_battle_callbacks[:on_no_damage](self)
    end
    if @battle_remarks.key?
      # Add remark handling here
    end
  end

  def on_critical_hit
    if @default_battle_callbacks.key?(:on_critical_hit)
      @default_battle_callbacks[:on_critical_hit](self)
    end
    if @battle_remarks.key?
      # Add remark handling here
    end
  end

  def on_killing_blow
    if @default_battle_callbacks.key?(:on_killing_blow)
      @default_battle_callbacks[:on_killing_blow](self)
    end
    if @battle_remarks.key?
      # Add remark handling here
    end
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
    return hp < mhp / 4
  end

  def is_upset?
    return is_critical? || happiness + confidence + courage < -90
  end

  def is_dead?
    return hp == 0
  end
end

# -*- coding: utf-8 -*-
#==============================================================================
# ** StateManager
#------------------------------------------------------------------------------
#  This Manager is used to precompute calculations
#==============================================================================
module StateManager

  @types = ["BODY", "SOUL"]
  @slices = {}

  def self.init
    in_slice = false
    state_type = nil
    $data_states.each_with_index do |state, i|
      if in_slice
        if !(@types.include?(state.name) || state.name.empty?)
          @slices[state_type][1] += 1
        else
          in_slice = false
          state_type = nil
        end
      end
      if state
        if @types.include?(state.name)
          # start a new slice
          @slices[state.name] = [i + 1, 0]
          in_slice = true
          state_type = state.name
        end
      end
    end
  end

  def self.is_type?(state_id, state_type)
    @slices[state_type][0] <= state_id && state_id < @slices[state_type][0] + @slices[state_type][1]
  end

  def self.type?(state_id)
    @slices.each do |key, slice|
      if slice[0] <= state_id && state_id < slice[0] + slice[1]
        return key
      end
    end
    nil
  end

  def self.type_size(state_type)
    @slices[state_type][1]
  end

  def self.type_exist?(state_type)
    @slices.key?(state_type)
  end

  def self.remove_light_soul_afflictions
    to_remove = []
    puts "RUNNING"
    puts $game_variables[1].states.length
    $game_variables[1].states.each do |state|
      if state.priority <= 0 && self.is_type(state.id, "SOUL")
        to_remove.push(state.id)
      end
    end
    to_remove.each do |state_id|
      $game_variables[1].remove_state(state_id)
    end
  end
end

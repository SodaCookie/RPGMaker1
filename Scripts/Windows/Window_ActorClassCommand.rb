# -*- coding: utf-8 -*-
class Window_ActorClassCommand < Window_ActorCommand

  def add_attack_command
    class_attribute = Variables::ClassSkills[@actor.class_id]
    add_command($data_skills[class_attribute.main_id].name, :attack, @actor.attack_usable?)
  end

  def add_guard_command
    class_attribute = Variables::ClassSkills[@actor.class_id]
    add_command($data_skills[class_attribute.second_id].name, :guard, @actor.guard_usable?)
  end

end

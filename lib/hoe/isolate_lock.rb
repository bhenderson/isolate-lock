module Hoe::Isolate_Lock
  def initialize_isolate_lock
    # does this work?
    ::Isolate.sandbox.options[:system] = false
  end

  def define_isolate_lock_tasks
    require 'isolate/lock/rake'
  end
end

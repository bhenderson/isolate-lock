require 'isolate'
require 'isolate/locker'

locker = nil

Isolate::Events.watch Isolate::Sandbox, :initializing do |sandbox|
  locker = Isolate::Locker.new sandbox
end

Isolate::Events.watch Isolate::Sandbox, :activated do
  locker.lock!
end

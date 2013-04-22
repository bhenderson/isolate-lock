require 'isolate/lock'

file 'Isolate.lock' => 'Isolate' do
  t = task(:isolate) and t.invoke

  File.open 'Isolate.lock', 'w' do |f|
    f.puts Isolate::Lock.new.run
  end
end

desc 'Generate a lock file for Isolate'
task 'isolate:lock' => 'Isolate.lock'

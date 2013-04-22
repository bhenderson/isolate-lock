class Isolate::Lock
  VERSION = "1.0.0"

  def self.run
    puts new.run
  end

  def initialize sandbox = Isolate.sandbox
    @lines = []
    @sandbox = sandbox
  end

  def run
    entries = @sandbox.entries.sort_by{|e| e.name}
    rest, groups = entries.partition{|e| e.environments.empty?}
    # can you really have more than one env?
    groups.sort_by!{|e| e.environments.first}

    last_env = nil

    (rest + groups).each do |entry|
      # first?
      env = entry.environments.first

      puts "end" if last_env and last_env != env

      puts "env #{env.inspect} do" if last_env != env

      gem entry.specification, (env ? '  ' : '')

      last_env = env
    end

    puts "end" if last_env

    @lines
  end

  def gem spec, prefix = ''
    puts "#{prefix}gem '#{spec.name}', '#{spec.version}'"
    # we don't want development_dependencies because they never get
    # installed.
    spec.runtime_dependencies.sort.each do |dep|
      gem dep.to_spec, prefix + '  '
    end
  end

  private

  def puts line
    @lines << line
  end
end

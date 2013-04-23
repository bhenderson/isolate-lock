class Isolate::Locker
  VERSION = "1.0.0"

  def initialize sandbox = Isolate.sandbox
    # force options.
    sandbox.options[:system]  = false
    sandbox.options[:cleanup] = true

    @lines = []
    # TODO config this.
    @lock_file = 'Isolate.lock'
    @sandbox = sandbox

    File.open @lock_file, 'a' do end # touch
  end

  def footer
    <<-"EOF"

# vim: ft=ruby
    EOF
  end

  def header
    <<-"EOH"
############################################
# DO NOT EDIT. This file was auto generated.
############################################

    EOH
  end

  def generate
    groups = Hash.new {|h,k| h[k] = []}

    @sandbox.entries.each do |entry|
      envs = entry.environments
      envs = [nil] if envs.empty?
      envs.each do |env|
        groups[env] << entry
      end
    end

    puts header

    groups.sort_by{|e, _| e.to_s}.each do |env, entries|
      puts nil, "env #{env.inspect} do" if env

      entries.sort_by{|e| e.name}.each do |entry|
        spec = entry.specification
        space = env ? '  ' : ''

        if spec
          gem spec, space
        else
          puts "#{space}# #{entry.name} unavailable. Make sure to set Isolate.env"
        end

        last_env = env
      end

      puts "end" if env

    end

    puts footer

    @lines
  end

  def lock!
    # lock if empty
    File.open @lock_file, 'w' do |f|
      f.puts generate
    end unless test ?s, @lock_file
  end

  private

  def gem spec, prefix = ''
    puts "#{prefix}gem '#{spec.name}', '= #{spec.version}'"
    # we don't want development_dependencies because they never get
    # installed.
    spec.runtime_dependencies.sort.each do |dep|
      gem dep.to_spec, prefix + '  '
    end
  end

  def puts *lines
    @lines.concat lines
  end

  def write_file &block
    File.open @lock_file, 'w', &block
  end

end

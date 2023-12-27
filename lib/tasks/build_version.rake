task :write_build_version do
  File.open('version.txt', 'w') do |f|
    f.write(Time.now.strftime('%Y%m%d%H%M%S'))
  end
end

Rake::Task['assets:precompile'].enhance ['write_build_version']

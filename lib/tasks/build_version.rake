task :write_build_version do
  File.write('version.txt', Time.now.strftime('%Y%m%d%H%M%S'))
end

Rake::Task['assets:precompile'].enhance ['write_build_version']

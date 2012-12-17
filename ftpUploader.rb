 require 'net/ssh'
 require 'net/sftp'
 Net::SSH.start('172.18.61.207', 'root', :password => "123456") do |ssh|
   ssh.sftp.connect do |sftp|
     Dir.foreach('.') do |file|
       next if File.stat(file).directory?
       begin
         local_file_changed = File.stat(file).mtime > Time.at(sftp.stat(file).mtime) 
       rescue Net::SFTP::Operations::StatusException 
        not_uploaded = true 
      end 
      if not_uploaded or local_file_changed 
       puts "#{file} has changed and will be uploaded" 
       sftp.put_file(file, file) 
      end 
    end 
  end 
end
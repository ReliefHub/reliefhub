namespace :maintenance do
  desc "Recreates image files if new formats are specified via paperc"
  task :recreate_image_files => :environment do
    puts "Recreating image files..."

    Organization.all.each do |organization|
      organization.organization_photos.each do |photo|
        puts "Reprocessing organization photo:#{photo.id}"
        photo.file.reprocess!
      end
    end
    
    Project.all.each do |project|
      project.project_photos.each do |photo|
        puts "Reprocessing project photo:#{photo.id}"
        photo.file.reprocess!
      end
    end
    puts "done"
  end
end

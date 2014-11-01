# usage resize
# run this command from the jekyll images/resize folder


images = []

Dir.glob("*.*").each do |f|
  # get the device type and orientation
  # smuff-product-tablet-side.png => tablet, side
  parts = f.split('-')
  orientation = parts.last.split('.').first
  device = parts[parts.size - 2]
  
  # output file name
  output = f.split('.png');
  
 
  # resize
  size = []
  image_names = []
  
  case device
    when "mobile"
      case orientation
        when "portrait"
          size << "320x0"
          size << "640x0"
          image_names << "mobile"
          image_names << "retina"
        when "side1", "side"
          size << "280x0"
          size << "560x0"
          image_names << "mobile"
          image_names << "retina"
      end
    
    when "tablet"
      case orientation
        when "portrait"
          size << "320x0"
          size << "480x0"
          image_names << "mobile"
          image_names << "tablet"
        when "angle1", "angle"
          size << "320x0"
          size << "732x0"
          size << "1024x0"
          size << "1440x0"
          image_names << "mobile"
          image_names << "tablet"
          image_names << "laptop"
          image_names << "desktop"
        when "side", "side1"
          size << "320x0"
          size << "514x0"
          image_names << "mobile"
          image_names << "retina"
      end
    
    when "desktop"
      size << "320x0"
      size << "768x0"
      size << "1024x0"
      image_names << "mobile"
      image_names << "tablet"
      image_names << "desktop"
    
    when "laptop"
      size << "320x0"
      size << "768x0"
      size << "1024x0"
      image_names << "mobile"
      image_names << "tablet"
      image_names << "desktop"
  end
  
  size.each_with_index do |s, i|
    i += 1
    o = "#{output[0]}-#{i}x.png"
    
    images << "#{image_names[i-1]}: #{o}"   
  
    puts "Resizing #{f} to #{s} and saving to #{o}"  
    puts system("wget http://localhost:8888/unsafe/#{s}/http://localhost:4000/assets/images/resize/#{f} -O #{o}")
    puts "Compressing #{o}"
    puts system("pngquant #{o}")
    puts ""
  end
end


images.each do |image|
  puts image
end

puts "To move files and remove -fs8.png:"
puts 'for i in *-fs8.png ; do mv "$i" "../${i/-fs8.png/.png}" ; done'


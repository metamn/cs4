# usage crop input-folder

input = ARGV[0].to_s if ARGV[0]

puts "Cropping from #{input} to the same directory"

Dir.glob("#{input}/*.*").each do |f|
  # remove unnecesarry substrings
  # smuff-product-tablet-screenshot_ipadmini_white_side.png => smuff-product-tablet-side.png
  name = f.split('-screenshot_')
  extension = name[1].split('_')
  file = name[0] + '-' + extension.last
  
  # get the device type and orientation
  # smuff-product-tablet-side.png => tablet, side
  parts = file.split('-')
  orientation = parts.last.split('.').first
  device = parts[parts.size - 2]
  
  # landscapes are useless
  next if orientation == 'landscape'
  
  # crop sizes
  case device
    when "mobile"
      case orientation
        when "portrait"
          size = "813x1677+0+0"
        when "side1"
          size = "645x1605+0-50" # pushed down
      end
    
    when "tablet"
      case orientation
        when "portrait"
          size = "898x1311+0-30" # pushed down
        when "angle1"
          size = "1840x910+0+30" # pushed up
        when "side"
          size = "514x1296-30+0" # pushed right
      end
    
    when "desktop"
      case orientation
        when "right"
          size = "1394x1700+0+0"
        when "left"
          size = "1394x1700+0+0"
        when "front"
          size ="1858x1570+0+0"
      end
  end
  
  puts "Cropping to #{file} at size #{size}"  
  puts system("convert #{f} -gravity Center -crop #{size} #{file}")
end
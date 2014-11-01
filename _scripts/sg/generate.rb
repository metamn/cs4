require_relative 'utils'

class Generate
  def initialize(object)
    @object = object
    @root = Dir.pwd
    
    @html = @root + "/_includes"
    @css = @root + "/assets/styles"
    @sg = @root + "/styleguide"
    
    @utils = Utils.new
    @object_partial = @utils.partial @object
    
    generate
  end
  
  def generate
    puts "Generating #{@object} into:"
    puts " - #{@html}"
    puts " - #{@css}"
    puts " - #{@sg}"
    
    html
    css
    sg
  end
  
  def html
    puts system("echo '' > #{@html}/#{@object}.html")
  end
  
  def css
    puts system("echo '#{@utils.mixin(@object)}' > #{@css}/#{@object_partial}.scss")
  end
  
  def sg
    puts system("echo '#{@utils.yaml(@object)}' > #{@sg}/#{@object}.html")
  end
end
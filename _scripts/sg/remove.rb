require_relative 'utils'


class Remove
  def initialize(object)
    @object = object
    @root = Dir.pwd
    
    @html = @root + "/_includes"
    @css = @root + "/assets/styles"
    @sg = @root + "/styleguide"
    
    @utils = Utils.new
    @object_partial = @utils.partial @object
    
    remove
  end
  
  def remove
    puts "Removing #{@object} into:"
    puts " - #{@html}"
    puts " - #{@css}"
    puts " - #{@sg}"
    
    puts system("rm #{@html}/#{@object}.html")
    puts system("rm #{@css}/#{@object_partial}.scss")
    puts system("rm #{@sg}/#{@object}.html")
  end
end
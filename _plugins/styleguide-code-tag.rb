module Jekyll
  class CodeTag < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
      @text = text.strip 
    end

    def render(context)
      # get which file to display, ie. full-height.scss
      # the file type to display is passed through via the @text parameter
      # ie. {% code scss %}
      filenames = context.environments.first["page"]["files"].select {|hash| hash["name"].include? "#{@text}"}
      filename = filenames.first["name"]
      
      # we've moved to SASS partials which means "_" should be appended to filename
      filename.prepend '_' if @text == "scss"
      
      # locate in which folder the file exists, ie 'atoms' of 'molecules'
      folder = context.environments.first["page"]["category"]
      
      # the root dir of the project
      root = Dir.pwd
      
      case @text
        when "scss"
          file = root + "/assets/styles/" + folder + "/" + filename
        when "html"
          file = root + "/_includes/" + folder + "/" + filename
        when "js"
          file = root + "/assets/scripts/" + folder + "/" + filename
        when "liquid"
          file = root + "/assets/styles/" + folder + "/" + filename
      end
      
      File.open(file, 'r') { |f| f.read } if File.exist? file
    end
  end
end

Liquid::Template.register_tag('code', Jekyll::CodeTag)
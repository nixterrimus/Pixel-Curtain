require 'rubygems'
require 'RMagick'

module PixelCurtain 
  class Curtain
    include Magick
    def initialize(source)
      if source.class == String
        @source_image = Image.read(file_path).first
      elsif source.class == Image
        @source_image = source
      end
      @output = Image.new(1440,900)
    end
  
    # Do nothing, this is to be implemented by subclasses
    def process(options = {})
      @output
    end
  
    def save(file_name, options = {})
      
      options[:temp_file] = false if options[:temp_file].nil?
      
      if options[:temp_file]
        output_file = Tempfile.new(['pixel_curtain', 'png'])
      else
        output_file = File.new(file_name, 'w')
      end
      
      @output.write("png:" + output_file.path)
      
      return output_file
    end
  
    private
    
    def average_color(image)
      total = 0
      avg = { :r => 0.0, :g => 0.0, :b => 0.0 }
      
      image.quantize.color_histogram.each do |c,n|
        avg[:r] += n * c.red
        avg[:g] += n * c.green
        avg[:b] += n * c.blue
        total += n
      end
      
      avg.each_key do |c| 
        avg[c] /= total
        avg[c] = (avg[c] / QuantumRange * 255).to_i
      end
      
      return "rgb(#{avg[:r]},#{avg[:g]},#{avg[:b]})"
    end
  end
end

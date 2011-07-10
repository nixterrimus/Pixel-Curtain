module PixelCurtain 
  class SimpleCurtain < Curtain
    def process(options = {})
      
      if options[:number_of_divisions].nil?
        number_of_divisions = 10
      else
        number_of_divisions = options[:number_of_divisions]
      end
    
      if (number_of_divisions > @source_image.columns)
        number_of_divisions = @source_image.columns
      end
    
      source_division_size = @source_image.columns / number_of_divisions
      destination_division_size = @output.columns / number_of_divisions
    
      gc = Draw.new
      
      (0...number_of_divisions).each do |x|
        avgPixel = average_color(@source_image.crop(source_division_size*x,0,
                    source_division_size,@source_image.rows))
        gc.fill(avgPixel)
        gc.rectangle(x*destination_division_size,0,x*destination_division_size+destination_division_size,@output.rows)
        gc.draw(@output)
      end
      
      @output    
    end
  end
end
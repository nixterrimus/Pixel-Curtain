module PixelCurtain 
  class ComplexCurtain < Curtain
    def process(options = {})
      colors = find_color_palette(10)
      gc = Draw.new
      current_position = 0
      
      while (current_position < @output.columns)
        current_color = colors[rand(colors.size)]
        puts current_color
        width = rand(100) + 10
        gc.fill(current_color)
        gc.rectangle(current_position,0,current_position+width,@output.rows)
        gc.draw(@output)
        current_position += width
      end
      
  
    end
    
    private
    
    def find_color_palette(number_of_colors = 3)
      source_division_size = @source_image.columns / number_of_colors
      colors = []
      (0...number_of_colors).each do |x|
        avgPixel = average_color(@source_image.crop(source_division_size*x,0,
                    source_division_size,@source_image.rows))
        colors[x] = avgPixel        
      end
      return colors
      
    end
  end
end
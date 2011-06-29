module PixelCurtain
  class Curtain
    def initialize(file_name)
      @source_image = ChunkyPNG::Image.from_file(file_name)
      @output = ChunkyPNG::Image.new(400,300)
    end
  
    def process(number_of_divisions=10)
    
      if (number_of_divisions > @source_image.dimension.width)
        number_of_divisions = @source_image.dimension.width
      end
    
      source_division_size = @source_image.dimension.width / number_of_divisions
      destination_division_size = @output.dimension.width / number_of_divisions
    
      (0...number_of_divisions).each do |x|
        avgPixel = @source_image.crop(source_division_size*x,0,
                    source_division_size,@source_image.dimension.height).average_pixel
        @output.setPixelBlock(x*destination_division_size,0,@output.dimension.height,destination_division_size,avgPixel)      
      end
      @output    
    end
  
    def save(file_name)
      @output.save(file_name)
    end
  
  end
end
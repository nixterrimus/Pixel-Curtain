module PixelCurtain 
  class Curtain
    include Magick
    def initialize(file_name)
      @source_image = Image.read(file_name).first
      @output = Image.new(1440,900)
    end
  
    def process(number_of_divisions=10)
    
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
  
    def save(file_name)
      @output.write(file_name)
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
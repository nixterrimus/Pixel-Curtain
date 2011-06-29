class ChunkyPNG::Image
  def average_pixel
    # Sum the total R, G, and B pieces
    ave = self.pixels.inject([0,0,0]) do |sum,element| 
      sum[0] += ChunkyPNG::Color.r(element)
      sum[1] += ChunkyPNG::Color.g(element)
      sum[2] += ChunkyPNG::Color.b(element)
      sum
    end
    # Cache the pixel_count value for speed
    pixel_count = self.pixels.count
    # Return the average value of each component as a new Color
    ChunkyPNG::Color.rgb(ave[0] / pixel_count, ave[1] / pixel_count, ave[2] / pixel_count)
  end
  
  def setPixelBlock(startX, startY, height, width, newPixel)
    (startX...startX+width).each do |x|
      (startY...startY+height).each do |y|
        self[x,y] = newPixel
      end
    end    
  end
end
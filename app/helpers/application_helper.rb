module ApplicationHelper
  def random_image
    images = ["/assets/producerun/hero-01.png", "/assets/producerun/hero-02.png"]
    images[rand(images.size)]
  end
end
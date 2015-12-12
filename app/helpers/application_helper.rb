module ApplicationHelper
  def random_image
    images = ["/assets/produceng/hero-01.png", "/assets/produceng/hero-02.png", "/assets/produceng/hero-03.png"]
    images[rand(images.size)]
  end
end

class Api::V1::UsersController < ApplicationController
  require 'chunky_png'
  require 'rmagick'
  def facebook
    if params[:facebook_access_token]
      # lay access token bang link https://developers.facebook.com/tools/explorer
      graph = Koala::Facebook::API.new params[:facebook_access_token]
      user_data = graph.get_object("me?fields=name,email,id,picture")
      user_data["email"] = "#{SecureRandom.hex}@gmail.com" unless user_data["email"]
      user = User.find_by uid: user_data["id"]
      if user
        user.generate_new_authentication_token
        return json_response "User Information", true, { user: user }, :ok
      else
        user = User.new(email: user_data["email"],
                        uid: user_data["id"],
                        provider: "facebook",
                        image: user_data["picture"]["data"]["url"],
                        password: Devise.friendly_token[0, 20])

        user.authentication_token = User.generate_unique_secure_token

        if user.save
          return json_response "Login Facebook Successfully", true, { user: user }, :ok
        else
          json_response user.errors, false, {}, :unprocessable_entity
        end
      end
    else
      json_response "Missing facebook access token", false, {}, :unprocessable_entity
    end
  end

  def text_to_image
    text = params[:text]
    font_size = 24
    font_path = Rails.root.join('app/assets/fonts/arial.ttf')
    color = 'red'

    # Tạo một đối tượng Magick::Image với kích thước hình ảnh mong muốn
    image = Magick::Image.new(400, 200) { |img| img.background_color = 'yellow' }

    # Tạo một đối tượng Magick::Draw để vẽ nội dung text lên hình ảnh
    draw = Magick::Draw.new
    draw.font = font_path.to_s
    draw.pointsize = font_size
    draw.fill = color
    draw.gravity = Magick::CenterGravity

    # Vẽ nội dung text lên hình ảnh
    draw.text(0, 0, text)
    draw.draw(image)

    # Lưu hình ảnh vào file
    image_first = SecureRandom.alphanumeric(16).downcase
    image_path = Rails.root.join('public', 'images', "#{image_first}.png")
    image.write(image_path)

    # Trả về đường dẫn đến hình ảnh để có thể sử dụng trong view hoặc gửi lại cho client
    render json: { image_url: "/images/#{image_first}.png" }
  end

  def generate_image
    @var = "123"
    html = <<-HTML
    <style>
      /* Chèn các quy tắc CSS tùy chỉnh ở đây */
      body {
        font-family: Arial, sans-serif;
        background-color: #yellow;
      }
      p {
        color: #ff0000;
      }
    </style>
    <p>Your HTML code goes here #{@var}</p>
    HTML

    imgkit = IMGKit.new(html)
    image = imgkit.to_img(:png)
    image_first = SecureRandom.alphanumeric(16).downcase

    # Chỉ định đường dẫn tệp tin cụ thể
    custom_path = Rails.root.join('public', 'images', "#{image_first}.png")

    File.open(custom_path, 'wb') do |file|
      file.binmode
      file.write(image)
    end

    render json: { image_path: custom_path.to_s }
  end
  # def generate_image
  #   @var = "123"
  #   html = <<-HTML
  #   <style>
  #     /* Chèn các quy tắc CSS tùy chỉnh ở đây */
  #     body {
  #       font-family: Arial, sans-serif;
  #       background-color: #f0f0f0;
  #     }
  #     p {
  #       color: #ff0000;
  #     }
  #   </style>
  #   <p>Your HTML code goes here #{@var}</p>
  #   HTML
  #
  #   imgkit = IMGKit.new(html)
  #   image = imgkit.to_img(:png)
  #
  #   # Chỉ định đường dẫn tệp tin cụ thể
  #   custom_path = Rails.root.join('public', 'images', 'custom_image.png')
  #
  #   File.open(custom_path, 'wb') do |file|
  #     file.binmode
  #     file.write(image)
  #   end
  #
  #   render json: { image_path: custom_path.to_s }
  # end
end

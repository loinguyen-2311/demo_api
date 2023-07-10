class AddReviewsCountToBooks < ActiveRecord::Migration[7.0]
  def self.up
    add_column :books, :reviews_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :books, :reviews_count
  end
end

# rails g counter_culture Book reviews_count
# Gem 'counter_culture' là một gem trong Ruby on Rails được sử dụng để tính toán và lưu trữ các giá trị đếm (counters) trong cơ sở dữ liệu.
# Nó giúp tăng hiệu suất và tối ưu hóa việc tính toán số lượng đối tượng liên quan trong mô hình dữ liệu.
# Khi bạn sử dụng gem 'counter_culture',
#nó cho phép bạn định nghĩa các counters trên các mối quan hệ giữa các mô hình. Khi các sự kiện (events) xảy ra trong mô hình, như tạo mới, cập nhật hoặc xóa đối tượng,
#gem 'counter_culture' sẽ tự động cập nhật các counters liên quan.
# Với 'counter_culture', bạn có thể tính toán và lưu trữ các giá trị đếm mà không cần thực hiện truy vấn phức tạp vào cơ sở dữ liệu mỗi khi bạn muốn lấy số lượng các đối tượng liên quan.
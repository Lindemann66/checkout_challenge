class Checkout
  def initialize
    @items = []
  end

  def scan(item)
    if items_meta.key?(item)
      items << item
    else
      puts "item #{item.inspect} is not found"
    end
  end

  def total
    total_before_promo = calculate_total
    Application.logger.info "Total before promotions is #{total_before_promo.inspect}"
    final_total = Promotions::apply(items, total_before_promo)
    Application.logger.info "Total after promotions is #{final_total.inspect}"
    final_total
  rescue => e
    Application.logger.error "Checkout error: #{e.message} at #{Time.now}"
  end

  private

  def items_meta
    Supermarket::items_meta
  end

  def items
    @items
  end

  def calculate_total
    total = 0
    items.each { |item| total += items_meta[item]['price'] }
    total
  end 
end
class Promotions
  class << self
    def apply(items, amount)
      @items = items
      @amount = amount

      ceo_promo
      coo_promo
      cto_promo

      @amount.round(2)
    end

    private

    def items_meta
      Supermarket::items_meta
    end

    def items
      @items
    end

    def ceo_promo
      code = Items::TEA_CODE
      count = items.count(code)
      @amount -= ((count / 2) * items_meta[code]['price']) if count >= 2
    end

    def coo_promo
      code = Items::STRAWBERRY_CODE
      count = items.count(code)
      meta = items_meta[code]
      
      @amount -= (count * (meta['price'] - meta['promo_price'])) if count >= 3
    end

    def cto_promo
      code = Items::COFFEE_CODE
      count = items.count(code)
      
      @amount -= (count * (items_meta[code]['price'] * (1.0 / 3.0))) if count >= 3
    end
  end
end
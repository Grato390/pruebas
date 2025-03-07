class Product < ApplicationRecord
  validates :name, presence: true

  # Calcula el tiempo restante para que una oferta termine
  def time_until_sale_ends(sale_end_time)
    time_remaining = sale_end_time - Time.current
    time_remaining > 0 ? time_remaining : 0
  end

  # Verifica si el producto está en stock
  def in_stock?
    stock > 0
  end

  # Devuelve el nombre en mayúsculas
  def uppercase_name
    name.upcase
  end

  # Verifica si el producto está en oferta
  def on_sale?(sale_price)
    price < sale_price
  end

  # Devuelve una descripción corta del producto
  def short_description
    description.truncate(30)
  end

  # Calcula el precio total con un descuento adicional
  def total_price_with_additional_discount(additional_discount_percentage)
    discounted_price = price - (price * 10 / 100.0)
    discounted_price - (discounted_price * additional_discount_percentage / 100.0)
  end

  # Verifica si el producto es nuevo (creado en los últimos 30 días)
  def new_product?
    created_at >= 30.days.ago
  end

  # Método vencido
  def self.vencido(entrada)
    entrada == 0 ? "vencido" : "vigente"
  end
end


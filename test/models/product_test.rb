require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  setup do
    @product = products(:one)
    @product.update(price: 1000, stock: 10) # Asegurar valores definidos
  end
  

  # Prueba para el método de validación de presencia del nombre
  test "should not save product without name" do
    product = Product.new
    assert_not product.save, "Saved the product without a name"
  end

  # Prueba para el método time_until_sale_ends
  test "should calculate time until sale ends" do
    sale_end_time = 1.hour.from_now
    assert_in_delta 3600, @product.time_until_sale_ends(sale_end_time), 1
  end

  # Prueba para el método time_until_sale_ends cuando la venta ha terminado
  test "should return zero if sale has ended" do
    sale_end_time = 1.hour.ago
    assert_equal 0, @product.time_until_sale_ends(sale_end_time)
  end

  # Prueba para el método in_stock?
  test "should check if product is in stock" do
    # assert @product.in_stock?
    # @product.stock = 0
    # assert_not @product.in_stock?

    puts "Stock actual: #{@product.stock.inspect}" # Depuración
    assert @product.in_stock?, "El producto debería estar en stock"

    @product.update(stock: 0)
    puts "Stock después de actualizar: #{@product.stock.inspect}" # Depuración
  assert_not @product.in_stock?, "El producto NO debería estar en stock"



  end

  # Prueba para el método uppercase_name
  test "should return uppercase name" do
    assert_equal @product.name.upcase, @product.uppercase_name
  end

  # Prueba para el método on_sale?
  test "should check if product is on sale" do
    assert @product.on_sale?(2000)
    assert_not @product.on_sale?(500)
  end

  # Prueba para el método short_description
  test "should return short description" do
    assert_equal @product.description.truncate(30), @product.short_description
  end

  # Prueba para el método total_price_with_additional_discount
  test "should calculate total price with additional discount" do
    assert_equal 810, @product.total_price_with_additional_discount(10)
  end

  # Prueba para el método new_product?
  test "should check if product is new" do
    assert @product.new_product?
    @product.created_at = 31.days.ago
    assert_not @product.new_product?
  end

  # Prueba para el método vencido
  test "should return vencido when input is 0" do
    assert_equal "vencido", Product.vencido(0)
  end

  test "should return vigente when input is not 0" do
    assert_equal "vigente", Product.vencido(1)
    assert_equal "vigente", Product.vencido(2)
    assert_equal "vigente", Product.vencido(-1)
  end
end
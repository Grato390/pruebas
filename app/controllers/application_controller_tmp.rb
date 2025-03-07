# filepath: /c:/ruby aqui/8proyect_prueba_unitario/pruebas/app/controllers/products_controller.rb
class ProductsController < ApplicationController
  # ...existing code...

  private

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:name, :price, :description, :stock)
  end
end
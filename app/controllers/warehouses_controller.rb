class WarehousesController < ApplicationController
  def show
    id = params[:id]
    @warehouse = Warehouse.find(id)
  end

  def new
  end

  def create
    #Aqui dentro nós vamos:
    # 1 - Receber os dados enviados
    # 2 - Criar um novo galpão (ou outra coisa) no banco de dados
    warehouse_params = params.require(:warehouse).permit(:name, :code, :city, :description, :address, :cep, :area)
    w = Warehouse.new(warehouse_params)
    w.save()
    # 3 - Redirecionar para a tela inicial (ou outro lugar)
    redirect_to root_path
  end
end
class ItemsController < ApplicationController

  def index
    @user = User.new
  end

  def new
     @item_form = ItemForm.new
     @item_form.item_variants_attributes = { "0" => { size_id: "", color_id: "", stock_quantity: "", price: "" } }
  end

  def create
    @item_form = ItemForm.new(item_params.except(:item_variants_attributes))
    @item_form.item_variants_attributes = item_params[:item_variants_attributes]
    if @item_form.save
      redirect_to root_path, notice: '商品を出品しました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item_form).permit(
      :name,
      :price,
      :description,
      :category_id,
      :gender_id,
      # item_variants_attributes でネストした属性の受け取りを許可します。
      # :id と :_destroy は更新・削除処理に必要です。
      item_variants_attributes: [:id, :size_id, :color_id, :stock_quantity, :_destroy]
    )
  end
end


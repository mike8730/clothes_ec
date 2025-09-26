class ItemsController < ApplicationController

  def index
    @user = User.new
  end

  def new
     @item = Item.new
     # フォームの初期状態でバリエーション入力欄を1つ表示するために build します。
     @item.item_variants.build
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path, notice: '商品を出品しました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(
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


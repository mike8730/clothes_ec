 データベース設計
# テーブル設計  

## users テーブル（ユーザー情報）
| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------  |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| last_name          | string | null: false               |
| first_name         | string | null: false               |
| last_name_kana     | string | null: false               |
| first_name_kana    | string | null: false               |
| birth_date         | date   | null: false               |

### Association
- has_one :cart
- has_many :orders

## items テーブル（商品情報）
| Column                 | Type       | Options                        |
|------------------------|------------|------------------------------- |
| name                   | string     | null: false                    |
| price                  | integer    | null: false                    |
| description            | text       | null: false                    |
| category_id            | integer    | null: false                    |
| gender_id              | integer    | null: false                    |
### Association
- has_many :cart_items, through: :item_variants
- has_many :order_items, through: :item_variants
- has_many :item_variants, inverse_of: :item
- belongs_to_active_hash :category
- belongs_to_active_hash :gender

## item_variants テーブル (SKU)
| Column                 | Type       | Options                        |
|------------------------|------------|------------------------------- |
| item                   | references | null: false, foreign_key: true |
| size                   | references | null: false, foreign_key: true |
| color                  | references | null: false, foreign_key: true |
| stock_quantity         | integer    | null: false, default: 0        |
| price                  | integer    |                                |
### Association
- belongs_to :item
- belongs_to :size
- belongs_to :color

## sizes テーブル
| Column                 | Type       | Options                        |
|------------------------|------------|------------------------------- |
| name                   | string     | null: false                    |
### Association
- has_many :item_variants

## colors テーブル
| Column                 | Type       | Options                        |
|------------------------|------------|------------------------------- |
| name                   | string     | null: false                    |
| code                   | string     |                                |
### Association
- has_many :item_variants


## carts テーブル（カート情報）
| Column                 | Type       | Options                        |
|------------------------|------------|------------------------------- |
| user                   | references | null: false, foreign_key: true |
### Association
- belongs_to :user
- has_many :cart_items

## cart_items テーブル（カート商品情報）
| Column                 | Type       | Options                        |
|------------------------|------------|------------------------------- |
| cart                   | references | null: false, foreign_key: true |
| item_variant           | references | null: false, foreign_key: true |
| quantity               | integer    | null: false                    |
### Association
- belongs_to :cart
- belongs_to :item_variant

## orders テーブル（購入情報）
| Column                 | Type       | Options                        |
|------------------------|------------|------------------------------- |
| user                   | references | null: false, foreign_key: true |
| status                 | string     | null: false, default: 'pending'|
| total_price            | integer    | null: false                    |
### Association
- belongs_to :user
- has_many :order_items

## order_items テーブル（購入商品情報）
| Column                 | Type       | Options                        |
|------------------------|------------|------------------------------- |
| order                  | references | null: false, foreign_key: true |
| item_variant           | references | null: false, foreign_key: true |
| quantity               | integer    | null: false                    |
### Association
- belongs_to :order
- belongs_to :item_variant

## ShippingAddresses テーブル (配送先情報)
| Column                 | Type       | Options                        |
|------------------------|------------|------------------------------- |
| order                  | references | null: false, foreign_key: true |
| postal_code            | string     | null: false                    |
| prefecture_id          | integer    | null: false                    |
| city                   | string     | null: false                    |
| address                | string     | null: false                    |
| building               | string     |                                |
| phone_number           | string     | null: false                    |
### Association
- belongs_to :order
- belongs_to_active_hash :prefecture 

## Favorites テーブル (お気に入り情報)
| Column                 | Type       | Options                        |
|------------------------|------------|------------------------------- |
| user                   | references | null: false, foreign_key: true |
| item                   | references | null: false, foreign_key: true |
### Association
- belongs_to :user
- belongs_to :item
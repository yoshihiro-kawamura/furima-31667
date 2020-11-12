# テーブル設計

## users テーブル

|  Column         |  Type   |  Options         |
| --------------- | ------- | ---------------- |
| email           | string  |   null: false    | 
| password        | string  |   null: false    |
| nickname        | string  |   null: false    |
| first_name      | string  |   null: false    |
| last_name       | string  |   null: false    |
| last_name_kana  | string  |   null: false    |
| first_name_kana | string  |   null: false    |

### Association
- has_many :items
- has_many :buys

## items テーブル

|  Column          |  Type      |  Options         |
| ---------------- | ---------- | ---------------- |
| item_name        | text       |   null: false    | 
| item_example     | text       |   null: false    |
| category         | text       |   null: false    |
| item_condition   | text       |   null: false    |
| shipping_charges | text       |   null: false    |
| area             | text       |   null: false    |
| day              | date       |   null: false    |
| price            | integer    |   null: false    |
| image            |        ActiveStorage          |
| user             | references |                  |

### Association
- belongs_to :user
- has_one :buys

## buys テーブル

|  Column     |  Type           |  Options    |
| ----------- | --------------- | ----------- |
| credit_card | integer         | null: false |
| expiration  | integer         | null: false |
| secrity     | integer         | null: false |

### Association
- belongs_to :user
- belongs_to :item
- has_one :destination

## destinations テーブル

|  Column       |  Type   |  Options    |
| ------------- | ------- | ----------- |
| postal_code   | string  | null: false |
| prefecture    | integer | null: false |
| city          | string  | null: false |
| house_number  | string  | null: false |
| building_name | string  | null: false |
| phone_number  | string  | null: false |

### Association
- belongs_to :buy
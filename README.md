# テーブル設計

## users テーブル

|  Column            |  Type   |  Options         |
| ------------------ | ------- | ---------------- |
| email              | string  |   null: false    | 
| encrypted_password | string  |   null: false    |
| nickname           | string  |   null: false    |
| first_name         | string  |   null: false    |
| last_name          | string  |   null: false    |
| last_name_kana     | string  |   null: false    |
| first_name_kana    | string  |   null: false    |
| birthday           |  date   |   null: false    |

### Association
- has_many :items
- has_many :buys

## items テーブル

|  Column             |  Type      |  Options            |
| ------------------- | ---------- | ------------------- |
| name                | string     |   null: false       |  
| example             | text       |   null: false       |
| category_id         | integer    |   null: false       |
| item_condition_id   | integer    |   null: false       |
| shipping_charge_id | integer    |   null: false       |
| area_id             | integer    |   null: false       |
| day_id              | integer    |   null: false       |
| price               | integer    |   null: false       |
| user                | integer    |  foreign_key: true  |

### Association
- belongs_to :user
- has_one :buy

## buys テーブル

|  Column     |  Type           |  Options           |
| ----------- | --------------- | ------------------ |
| user        | integer         |  foreign_key: true |
| item        | integer         |  foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :destination

## destinations テーブル

|  Column       |  Type   |  Options    |
| ------------- | ------- | ----------- |
| postal_code   | string  | null: false |
| prefecture_id | integer | null: false |
| city          | string  | null: false |
| house_number  | string  | null: false |
| building_name | string  |             |
| phone_number  | string  | null: false |

### Association
- belongs_to :buy
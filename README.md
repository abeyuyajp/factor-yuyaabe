# README

## users テーブル

| Column             | Type    | Options      |
| ------------------ | ------- | ------------ |
| nickname           | string  | null: false  |
| email              | string  | null: false  |
| encrypted_password | string  | null: false  |
| team               | string  | null: false  |
| position           | string  | null: false  |
| career             | text    |              |
| birth_day          | date    |              |
| play_position      | string  |              |
| height             | integer |              |
| weight             | integer |              |
| text               | text    |              |

### Association
- has_many :posts
- has_many :room_users
- has_many :rooms, through: :room_users
- has_many :messages

## rooms テーブル
| Column             | Type        | Options                        |
| ------------------ | ----------- | -------------------------------|
|                    |             |                                |

### Association
- has_many :room_users
- has_many :users, through: :room_users
- has_many :messages

## room_users テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references |  foreign_key: true             |
| room   | references |  foreign_key: true             |

### Association

- belongs_to :user
- belongs_to :room


## messagesテーブル
| Column             | Type        | Options                         |
| ------------------ | ----------- | ------------------------------- |
| user               | references  | foreign_key: true              |
| room               | references  | foreign_key: true              |
| text               | text        | null: false                     |

### Association
- belongs_to :user
- belongs_to :room


## postsテーブル
| Column             | Type        | Options                         |
| ------------------ | ----------- | ------------------------------- |
| user               | references  | null: false, foreign_key: true  |
| title              | string      | null: false                     |
| youtube_url        | string      | null: false                     |
| text               | text        | null: false                     |

### Association
- belongs_to :user

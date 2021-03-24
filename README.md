# FACTOR

## アプリケーション概要
「チャレンジャーが報われる社会を作りたい」、「コロナ禍でもチャレンジしようと思っている人を応援したい」。そう思ってこのアプリを作りました。

このアプリは、アマチュアスポーツ選手たちが自身の活躍している姿を動画で発信できるサービスです。

## 選手側の課題
- 強豪校やプロチームに入るためのチャンスが少ない。
- コロナ禍において、そのチャンスはさらに減っている。
- 既存の代替品（YouTubeやTwitter）でアピールするには、個人の発信力や影響力が必要になる。

## チーム側(スカウト)の課題
- 選手を発掘することのハードルの高さ
- 既存の代替品（YouTubeやTwitter）では見つけるのが難しいため、選手の発掘にそれらを利用しようとは思わない。

## 解決策
選手とチーム関係者だけのプラットフォームを提供します。この場で選手が自分のプレー動画を発信することでお互いの機会損失を防ぐことができます。

## ターゲット
プロスポーツ選手を目指す高校生や大学生、実業団などで活動する社会人

## デプロイ後のURL
https://factor-yuyaabe.herokuapp.com/

## テスト用アカウント
- nickname : test
- email    : test@example
- password : test0618

# DEMO
## トップ画面
![index](https://user-images.githubusercontent.com/76641435/112250696-3280fb80-8c9d-11eb-8b6e-06beb784f913.png)

1. 投稿された動画を一覧できるページです。
2. 投稿をクリックすると投稿詳細ページへ、
   ユーザー名をクリックするとユーザー詳細ページへ遷移されます。

## ユーザー新規登録画面
![ragistration](https://user-images.githubusercontent.com/76641435/112250871-8be92a80-8c9d-11eb-83c5-8a40dbbef27d.png)

1. ユーザーネームを入力します。
2. メールアドレスを入力します。
3. パスワードを入力します。
4. 現所属チームを入力します。
5. 選手 or チーム関係者を選択します。
6. 「登録する」ボタンを押すと登録が完了します。

## ユーザー詳細ページ
![show](https://user-images.githubusercontent.com/76641435/112250959-afac7080-8c9d-11eb-9016-648c8547306d.png)

1. ユーザーの投稿や詳細を見ることができます。
2. 「メッセージを送る」ボタンを押すと、メッセージルームへ遷移されます。

## ダイレクトメッセージ機能
![message](https://user-images.githubusercontent.com/76641435/112251103-f9955680-8c9d-11eb-8090-de497d2562d0.png)

1. 入力欄にテキストを入力して送信すると、相手にメッセージが送信されます。

## 新規投稿画面
![new](https://user-images.githubusercontent.com/76641435/112251158-1467cb00-8c9e-11eb-8c51-518e98131353.png)

1. タイトルを入力します。
2. YouTubeのURLをコピーして貼り付けます。
   ※動画公開側の設定によっては、動画を読み込めなくなる場合がございます。
3. アピールポイントや説明を入力します。
4. 「投稿する」ボタンを押すと、トップページに追加されます。

## 使用言語・技術
- Ruby
- Ruby on Rails
- HTML/CSS
- AWS(S3)
- SQL


## 実装予定の機能
- メッセージ通知機能
- メッセージ一覧機能
- SNSアカウント連携機能

# データベース設計
## users テーブル

| Column             | Type    | Options      |
| ------------------ | ------- | ------------ |
| email              | string  | null: false  |
| encrypted_password | string  | null: false  |
| nickname           | string  | null: false  |
| team               | string  | null: false  |
| position           | string  | null: false  |
| career             | text    |              |

### Association
- has_many :posts
- has_many :room_users
- has_many :rooms, through: :room_users
- has_many :messages

## rooms テーブル

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
| user               | references  | foreign_key: true               |
| room               | references  | foreign_key: true               |
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

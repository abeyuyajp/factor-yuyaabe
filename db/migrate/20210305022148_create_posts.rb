class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.references :user,             null: false, foreign_key: true
      t.string :title,                null: false
      t.string :youtube_url,          null: false
      t.text   :text,                 null: false
      t.timestamps
    end
  end
end

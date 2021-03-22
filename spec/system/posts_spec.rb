require 'rails_helper'

RSpec.describe "投稿機能", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @post_title = Faker::Lorem.sentence
    @post_text = Faker::Lorem.sentence
    @post_youtube_url = 'https://www.youtube.com/watch?v=4nTTWcHD-D8&t=6344s'
  end
  context '投稿ができるとき' do
    it 'ログインしたユーザーは投稿できる' do
      # ログインする
      binding.pry
      visit new_user_session_path
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      find('input[name="commit"]').click
      # 新規投稿ページに遷移するボタンがあることを確認する
      expect(page).to have_content("post")
      # 投稿ページに移動する
      visit new_post_path
      # フォームに情報を入力する
      fill_in 'post[title]', with: @post_title
      fill_in 'post[youtube_url]', with: @post_youtube_url
      fill_in 'post[text]', with: @post_text
      # 送信ボタンを押すと、Postモデルのレコードが1増える
      find('input[name="commit"]').click
      # トップページに遷移することを確認する
      visit root_path
      # トップページに新しい投稿が存在することを確認する
      expect(page).to have_content(@post_title)
    end
  end
  context '投稿できないとき' do
    it 'ログインしていないと新規投稿ページに遷移されない' do
      # トップページに遷移する
      visit root_path
      # 新規投稿ページに移動しようとすると、ログインページに遷移される
      visit new_post_path
    end
  end
end

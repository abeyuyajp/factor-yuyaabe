require 'rails_helper'

RSpec.describe "ユーザー新規登録", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context '新規登録ができるとき' do
    it '正しい情報を入力すれば新規登録ができてトップページに移動する' do
      # トップページに移動する
      visit root_path
      # トップページに新規登録ページへ遷移するボタンがあることを確認する
      expect(page).to have_content("新規登録")
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'user[nickname]', with: @user.nickname
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      fill_in 'user[password_confirmation]', with: @user.password_confirmation
      fill_in 'user[team]', with: @user.team
      choose '選手'
      # 新規登録ボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit').click
      }.to change { User.count }.by(1)
      # トップページへ遷移したことを確認する
      expect(current_path).to eq(root_path)
      # カーソルを合わせるとログアウトボタンが表示されることを確認する
      expect(
        find('.user_nav').find('span').hover
      ).to have_content('ログアウト')
      # 新規登録ページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに移動する
      visit root_path
      # トップページに新規登録ページへ遷移するボタンがあることを確認する
      expect(page).to have_content("新規登録")
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'user[nickname]', with: ''
      fill_in 'user[email]', with: ''
      fill_in 'user[password]', with: ''
      fill_in 'user[password_confirmation]', with:''
      fill_in 'user[team]', with:''
      # 新規登録ボタンを用意してもユーザーモデルのカウントは上がらないことを確認する
      expect{
        find('input[name="commit').click
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq('/users')
    end
  end
end

RSpec.describe 'ログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'ログインができるとき' do
    it '保存されているユーザーの情報と合致すればログインができる' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content("ログイン")
      # ログインページへ移動する
      visit new_user_session_path
      # 正しいユーザー情報を入力する
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移されることを確認する
      expect(current_path).to eq(root_path)
      # カーソルを合わせるとログアウトボタンが表示されることを確認する
      expect(find('.user_nav').find('span').hover).to have_content('ログアウト')
      # 新規登録ページへ遷移するボタンやログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
  context 'ログインできないとき' do
    it '保存されているユーザーの情報と合致しなければログインできない' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content("ログイン")
      # ログインページへ移動する
      visit new_user_session_path
      # 誤った情報を入力する
      fill_in 'user[email]', with: ''
      fill_in 'user[password]', with: ''
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ログインページへ戻されることを確認する
      expect(current_path).to eq('/users/sign_in')
    end
  end
end

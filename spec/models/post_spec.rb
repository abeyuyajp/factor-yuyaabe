require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "投稿の保存" do
    before do
      @post = FactoryBot.build(:post)
    end

    context "投稿を保存できる時" do
      it "全ての情報があれば保存できる" do
        expect(@post).to be_valid
      end
    end
    context "投稿を保存できない時" do
      it "titleが空では保存できない" do
        @post.title = ""
        @post.valid?
        expect(@post.errors.full_messages).to include("タイトルを入力してください")
      end
      it "titleが100文字以上では保存できない" do
        @post.title = "あああああああああああああああああああああああああああああああああああああああ
        ああああああああああああああああああああああああああああああああああああああああああああああああ
        ああああああああああああああああああああああああああああああああああああああああああああああああ
        あああああああああああああああああああああああああああああああああああああああああああああああ"
        @post.valid?
        expect(@post.errors.full_messages).to include("タイトルが長すぎます")
      end
      it "youtube_urlが空では保存できない" do
        @post.youtube_url = ""
        @post.valid?
        expect(@post.errors.full_messages).to include("動画URLを入力してください")
      end
      it "userが紐づいていないと投稿できない" do
        @post.user = nil
        @post.valid?
        expect(@post.errors.full_messages).to include("Userを入力してください")
      end
    end
  end
end

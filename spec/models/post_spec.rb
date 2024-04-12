require 'rails_helper'

RSpec.describe Post, type: :model do
	let!(:user) { create(:user, account: 'example') }
	context 'タイトルと内容が入力されている場合' do

		let!(:post) { build(:post, user: user) }

		it '記事を保存できる' do
			expect(post).to be_valid
		end
	end
end

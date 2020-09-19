require 'rails_helper'
RSpec.describe 'ラベル管理機能', type: :system do
  let!(:general_user) { FactoryBot.create(:general_user, name: 'general_user') }
  let!(:admin_user) { FactoryBot.create(:admin_user, 
                                        name: 'admin_user', 
                                        email: 'admin@icloud.com', 
                                        password: 'admin') }
  let!(:label) { FactoryBot.create(:label, name: 'label_1') }
  let!(:third_label) { FactoryBot.create(:third_label, name: 'label_3', user: admin_user) }
  let!(:fourth_label) { FactoryBot.create(:fourth_label, name: 'label_4', user: general_user) }
  before do
    visit new_session_path
    fill_in "Email", with: "admin@icloud.com"
    fill_in "Password", with: "admin"
    click_button "ログイン"
  end
  describe '新規作成機能' do
    context 'ラベルを新規作成した場合' do
      it '作成したラベルが表示される' do
        visit new_label_path
        fill_in "名前", with: "label_test"
        click_on "登録"
        expect(page).to have_content 'label_test'
      end
      before do
        visit new_task_path
      end
      it '自分が作成したラベルをタスクに使用できる' do
        fill_in "タイトル", with: "label_test"
        fill_in "内容", with: "labe_test"
        fill_in "終了期限", with: Time.current.next_week
        select "未着手", from: "ステータス"
        within '#label-test' do
          check "label_3"
        end
        click_on "登録"
        click_on "登録"
        expect(page).to have_content 'label_3'
      end
      it '他の人が作成したラベルは表示されない' do
        expect(page).not_to have_content 'label_4'
      end
    end
  end

end
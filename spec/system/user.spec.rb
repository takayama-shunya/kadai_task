require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do
  describe 'ユーザー登録機能' do
    context 'ユーザーを新規作成した場合' do
      it '作成したユーザーが表示される' do
        visit new_user_path
        fill_in "名前", with: "user_test"
        fill_in "アドレス", with: "test@icloud.com"
        fill_in "パスワード", with: "password"
        fill_in "パスワード（確認）", with: "password" 
        click_on "登録"
        expect(page).to have_content 'user_test'
      end
    end
    context 'ログインせずにタスク一覧画面に移動しようとした場合' do
      it 'ログイン画面に遷移すること' do
        visit tasks_path
        expect(page).to have_content 'ログインして下さい'
      end
    end
  end
  let!(:admin_user) { FactoryBot.create(:admin_user, 
                                        name: 'admin_user',
                                        email: 'admin@icloud.com',
                                        password: 'admin',
                                        admin: 'true') }
  let!(:general_user) { FactoryBot.create(:general_user, 
                                        name: 'general_user',
                                        email: 'general@icloud.com',
                                        password: 'general',
                                        admin: 'false') }
  describe 'セッション機能' do
    context 'ログインした場合' do
      it 'ログインユーザー名が表示される' do
        visit new_session_path
        fill_in "Email", with: "admin@icloud.com"
        fill_in "Password", with: "admin"
        click_button "ログイン"
        expect(page).to have_content 'admin_user'
      end
    end
    before do
      visit new_session_path
      fill_in "Email", with: "general@icloud.com"
      fill_in "Password", with: "general"
      click_button "ログイン"
    end
    context 'ログイン時' do
      it '自分の詳細画面にアクセスできること' do
        visit user_path(general_user)
        expect(page).to have_content 'ユーザー詳細'
      end
    end
    context '一般ユーザーログイン時' do
      it '他人の詳細画面にアクセスするとタスク一覧画面に遷移されること' do
        visit user_path(admin_user)
        expect(page).to have_content '権限がありません'
      end
    end
    context 'ログイン時' do
      it 'ログアウトできること' do
        click_link "ログアウト"
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end
  describe '管理者画面機能' do
    context '一般ユーザーが管理者画面アクセスした場合' do
      before do
        visit new_session_path
        fill_in "Email", with: "general@icloud.com"
        fill_in "Password", with: "general"
        click_button "ログイン"
      end
      it 'タスク一覧画面に遷移されること' do
        visit admin_users_path
        expect(page).to have_content '管理者権限がありません'
      end
    end
    before do
      visit new_session_path
      fill_in "Email", with: "admin@icloud.com"
      fill_in "Password", with: "admin"
      click_button "ログイン"
    end
    context '管理ユーザーログイン時' do
      it '管理画面にアクセスできること' do
        visit admin_users_path
        expect(page).to have_content 'ユーザー一覧'
      end
      it 'ユーザーの新規登録ができること' do
        visit new_admin_user_path
        fill_in "名前", with: "user_test"
        fill_in "アドレス", with: "test@icloud.com"
        fill_in "パスワード", with: "password"
        fill_in "パスワード（確認）", with: "password"
        check "管理者権限" 
        click_on "登録"
        expect(page).to have_content 'user_test'
      end
      it 'ユーザー詳細画面にアクセスできること' do
        visit admin_users_path
        all('#test-info')[1].click_link "詳細"
        expect(page).to have_content 'ユーザー詳細'
      end
      it 'ユーザーを編集できること' do
        visit admin_users_path
        all('#test-edit')[1].click_link "編集"
        fill_in "名前", with: "general_test"
        fill_in "アドレス", with: "general@icloud.com"
        fill_in "パスワード", with: "password"
        fill_in "パスワード（確認）", with: "password"
        uncheck "管理者権限" 
        click_on "更新"
        expect(page).to have_content 'general_test'
      end
      it 'ユーザー削除できること' do
        visit admin_users_path
        all('#test-destroy')[1].click_link "削除"
        expect(page.accept_confirm).to eq "本当に削除して良いですか？"
        expect(page).to have_content '削除しました'
      end
    end
  end
end

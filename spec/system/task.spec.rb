require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in "Title", with: "task_test"
        fill_in "Content", with: "task_test"
        click_on "作成"
        click_on "作成"
        expect(page).to have_content 'task'

      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, title: 'task_1')
        visit tasks_path
        expect(page).to have_content 'task_1'
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task, title: 'task_2')
        visit task_path(task.id)
        expect(page).to have_content 'task_2'
       end
     end
  end
end
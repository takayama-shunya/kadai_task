require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in "タイトル", with: "task_test"
        fill_in "内容", with: "task_test"
        fill_in "終了期限", with: Time.current.next_week
        select "未着手", from: "ステータス"
        click_on "作成"
        click_on "作成"
        expect(page).to have_content 'task'
        expect(page).to have_content '未着手'
        #expect(page).to have_select('【ステータス】', selected: '未着手')
      end
    end
  end
  let!(:task) { FactoryBot.create(:task, title: 'task_1') }
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        visit tasks_path
        expect(page).to have_content 'task_1'
      end
    end
    let!(:second_task) { FactoryBot.create(:second_task, title: 'task_2') }
    before do
      visit tasks_path
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task_list = all('#task-test')
        expect(task_list[0]).to have_content 'task_2'
      end
    end
    context 'タスクが終了期限の降順に並んでいる場合' do
      it '終了期限が遠いタスクが一番上に表示される' do
        find('#expired-desc').click
        task_list = all('#task-test')
        expect(task_list[0]).to have_content 'task_2'
      end
      it '終了期限が近いタスクが一番上に表示される' do
        find('#expired-asc').click
        task_list = all('#task-test')
        expect(task_list[0]).to have_content 'task_1'
      end
    end
    context 'タスクが優先度の降順に並んでいる場合' do
      it '優先度が高いタスクが一番上に表示される' do
        find('#priority-desc').click
        task_list = all('#task-test')
        expect(task_list[0]).to have_content 'task_2'
      end
      it '優先度が低いタスクが一番上に表示される' do
        find('#expired-asc').click
        task_list = all('#task-test')
        expect(task_list[0]).to have_content 'task_1'
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
  describe '検索機能' do
    let!(:task) { FactoryBot.create(:task, title: "task") }
    let!(:second_task) { FactoryBot.create(:second_task, title: "search") }
    before do
      visit tasks_path
    end
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        fill_in "タイトル", with: "a"
        click_on "検索"
        expect(page).to have_content 'task'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        select "未着手", from: "ステータス"
        click_on "検索"
        expect(page).to have_content 'task'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        fill_in "タイトル", with: "a"
        select "着手中", from: "ステータス"
        click_on "検索"
        expect(page).to have_content 'search'
      end
    end
  end
end
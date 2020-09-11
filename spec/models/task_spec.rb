require 'rails_helper'

RSpec.describe Task, type: :model do
  let!(:admin_user) { FactoryBot.create(:admin_user,
    name: 'admin_user',
    email: 'admin@icloud.com',
    password: 'admin',
    admin: 'true') }

  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(title: '', content: '失敗テスト')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(title: '失敗テスト', content: '')
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = User.first.tasks.build(title: '成功テスト', content: '成功テスト')
        expect(task).to be_valid
      end
    end
  end
  describe '検索機能' do
    let!(:task) { FactoryBot.create(:task, title: 'task', user: admin_user) }
    let!(:second_task) { FactoryBot.create(:second_task, title: "sample", user: admin_user) }
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        expect(Task.title_like('task')).to include(task)
        expect(Task.title_like('task')).not_to include(second_task)
        expect(Task.title_like('task').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.status_name('着手中')).to include(second_task)
        expect(Task.status_name('着手中')).not_to include(task)
        expect(Task.status_name('着手中').count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.title_like('task').status_name('未着手')).to include(task)
        expect(Task.title_like('task').status_name('未着手')).not_to include(second_task)
        expect(Task.title_like('task').status_name('未着手').count).to eq 1
      end
    end
  end
end

require 'rails_helper'

RSpec.describe Label, type: :model do

  let!(:label) { FactoryBot.create(:label, name: 'label1') }
  describe 'バリデーションのテスト' do
    context 'ラベルの名前が同じ場合' do
      it 'バリデーションにひっかる' do
        label = Label.new(name: 'label1')
        expect(label).not_to be_valid
      end
    end
    context 'ラベルの名前が21文字以上の場合' do
      it 'バリデーションにひっかる' do
        name = "a" * 21
        label = Label.new(name: "#{name}")
        expect(label).not_to be_valid
      end
    end
    context 'ラベルの名前が同じでなく、20文字以内の場合' do
      it 'バリデーションが通る' do
        label = Label.new(name: 'label2')
        expect(label).to be_valid
      end
    end
  end
end

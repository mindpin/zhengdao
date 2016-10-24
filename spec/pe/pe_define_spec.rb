require 'rails_helper'

describe PeDefine, type: :model do
  describe '创建体检项目' do
    it 'create' do
      pd = PeDefine.create(name: 'test')
      expect(PeDefine.count).to eq(1)
    end

    it 'create' do
      facts = [create(:pe_fact), create(:pe_fact), create(:pe_fact), create(:pe_fact)]
      pd = PeDefine.create(name: 'test', facts: facts)
      expect(PeDefine.count).to eq(1)
      expect(PeDefine.last.fact_names.length).to eq(4)
    end
  end
end
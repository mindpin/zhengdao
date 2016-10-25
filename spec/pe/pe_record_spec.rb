require 'rails_helper'

describe PeRecord, type: :model do
  describe '保存记录数据' do
    it 'with sentences' do
      p = PeRecord.create({
        sentences: [
          PeSentence.new({
            data: [
              {fact: '', values: ['', '']},
              {fact: '', values: ['', '']},
              {custom: ''}
            ]
          }),
          PeSentence.new({
            data: [
              {fact: '', values: ['', '']},
              {fact: '', values: ['', '']},
              {custom: ''}
            ]
          }),
          PeSentence.new({
            data: [
              {fact: '', values: ['', '']},
              {fact: '', values: ['', '']},
              {custom: ''}
            ]
          }),
        ]
      })

      expect(PeRecord.last.sentences.count).to eq(3)
      expect(PeSentence.count).to eq(3)
    end
  end
end
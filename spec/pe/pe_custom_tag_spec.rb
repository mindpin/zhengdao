require 'rails_helper'

describe PeCustomTag, type: :model do
  before {
    fact1 = PeFact.create({
      name: '颜色', 
      tags: %w{黑色 白色 灰色 红色 蓝色 绿色}.map {|name|
        PeTag.create(name: name)
      }
    })

    fact2 = PeFact.create({
      name: '形状', 
      tags: %w{圆形 方形 三角形}.map {|name|
        PeTag.create(name: name)
      }
    })

    PeDefine.create(name: 'test', facts: [fact1, fact2])
  }

  describe '创建体检定义' do
    it 'create' do
      expect(PeFact.count).to eq(1 + 1)
      expect(PeTag.count).to eq(6 + 3)
      expect(PeDefine.count).to eq(1)
    end
  end

  describe '传入自定义标签' do
    before {
      pe_define = PeDefine.last
      PeRecord.create({
        pe_define: pe_define
      })
    }

    it 'count' do
      expect(PeRecord.count).to eq(1)
    end

    describe '自定义' do
      before {
        pe_record = PeRecord.last
        PeSentence.create({
          data: [
            {'fact' => '颜色', 'values' => ['黑色', '白色', '~粉色', '~透明']},
            {'fact' => '形状', 'values' => ['三角形', '~椭圆形']},
            {'custom' => '这是自定义语句'}
          ],
          pe_record: pe_record
        })
      }

      it 'save' do
        expect(PeRecord.last.sentences.count).to eq(1)
      end

      it 'custom-tags' do
        fact1 = PeFact.where(name: '颜色').first
        expect(fact1.custom_tags.count).to eq(2)

        fact2 = PeFact.where(name: '形状').first
        expect(fact2.custom_tags.count).to eq(1)
      end

      describe '继续增加' do
        before {
          pe_record = PeRecord.last
          PeSentence.create({
            data: [
              {'fact' => '颜色', 'values' => ['黑色', '白色', '~粉色', '~透明', '~彩虹']},
              {'fact' => '形状', 'values' => ['三角形', '~椭圆形', '~环形']},
              {'custom' => '这是自定义语句'}
            ],
            pe_record: pe_record
          })
        }

        it 'custom-tags' do
          fact1 = PeFact.where(name: '颜色').first
          expect(fact1.custom_tags.count).to eq(3)

          fact2 = PeFact.where(name: '形状').first
          expect(fact2.custom_tags.count).to eq(2)
        end
      end
    end

  end
end
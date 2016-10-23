require 'rails_helper'

describe PeFact, type: :model do
  describe '创建体检特征' do
    it 'create' do
      fact = PeFact.create({
        name: '颜色', 
        tags: %w{黑色 白色 灰色 红色 蓝色 绿色}.map {|name|
          PeTag.create(name: name)
        }
      })

      expect(PeFact.count).to eq(1)
      expect(PeTag.count).to eq(6)
    end

    it 'tag_names' do
      fact = PeFact.create({
        name: '颜色', 
        tags: %w{黑色 白色 灰色 红色 蓝色 绿色}.map {|name|
          PeTag.create(name: name)
        }
      })

      expect(fact.tag_names).to match_array(%w{黑色 白色 灰色 红色 蓝色 绿色})
    end

    it 'create_from_tag_names' do
      fact = PeFact.create({
        name: '形状', 
        tag_names: %w{三角形 正方形 矩形 五角形 六边形 圆形}
      })

      expect(PeFact.count).to eq(1)
      expect(PeTag.count).to eq(6)
      expect(fact.tag_names).to match_array(%w{三角形 正方形 矩形 五角形 六边形 圆形})
    end

    it 'change tag_names' do
      fact = PeFact.create({
        name: '形状', 
        tag_names: %w{三角形 正方形 矩形 五角形 六边形 圆形}
      })

      fact.tag_names = %w{圆形 椭圆形 环形}
      fact.save

      expect(PeFact.count).to eq(1)
      expect(PeTag.count).to eq(3)
      expect(fact.tag_names).to match_array(%w{环形 圆形 椭圆形})
    end
  end
end
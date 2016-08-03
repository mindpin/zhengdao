class FactGroup
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name

  has_many :fact_tags
  has_and_belongs_to_many :children, class_name: 'FactGroup'

  validates :name, presence: true

  def descendants_and_self
    fgs = self.children.map{|child|child.descendants_and_self}.flatten
    fgs.push self
    fgs
  end

  def tags=(tags)
    tags = tags.split(/，|,| /) if tags.is_a?(String)
    @tags = tags
  end

  validate :check_tags
  def check_tags
    return if @tags == nil
    return errors.add(:tags,"必须是一个字符串数组") if !@tags.is_a?(Array)
    @tags.each do |tag|
      return errors.add(:tags, "必须是一个字符串数组") if !tag.is_a?(String)
    end
    if @tags.uniq.count != @tags.count
      return errors.add(:tags, "不允许有重复元素") if !tag.is_a?(String)
    end
  end

  validate :only_have_fact_groups_or_have_fact_tags
  def only_have_fact_groups_or_have_fact_tags
    has_error1 = @tags !=nil && !self.children.blank?
    has_error2 = !self.fact_tags.blank? && !self.children.blank?

    if has_error1 || has_error2
      errors.add(:base, "不能同时含有子特性和特征值")
    end
  end

  after_save :create_tags
  def create_tags
    return if @tags == nil

    p 2222222222222
    p @tags

    new_tags = @tags.map do |tag_name|
      ft = fact_tags.select{|t|t.name == tag_name}.first
      ft = FactTag.create(name: tag_name, fact_group: self) if ft.blank?
      ft
    end
    old_tags = fact_tags - new_tags
    old_tags.each do |tag|
      tag.destroy
    end

    self.fact_tags = new_tags
    @tags = nil
    self.save
  end

end

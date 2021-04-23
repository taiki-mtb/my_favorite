class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    old_tags.each do |old|
      self.tags.delete Tag.find_by(tag_name: old)
    end

    new_tags.each do |new|
      add_tags = Tag.find_or_create_by(tag_name: new)
      self.tags << add_tags
    end
  end

  def save_list(sent_lists)
    current_lists = self.lists.pluck(:list_name) unless self.lists.nil?
    old_lists = current_lists - sent_lists
    new_lists = sent_lists - current_lists

    old_lists.each do |old|
      self.lists.delete List.find_by(list_name: old)
    end

    new_lists.each do |new|
      add_lists = List.find_or_create_by(list_name: new)
      self.lists << add_lists
    end
  end
end

class Idea < ApplicationRecord

    has_many :likes, dependent: :destroy
    has_many :likers, through: :likes, source: :user

    has_many :joins, dependent: :destroy
    has_many :joiners, through: :joins, source: :user

    before_validation :capitalize_title
    
    before_destroy :log_delete_details, unless: Proc.new { !Rails.env.development? }
  
    validates(:title,
      presence: true,
      uniqueness: true
    )
    validates :description, presence: true, length: { minimum: 10 }

    belongs_to :user
  
    has_many :reviews, -> { order('updated_at DESC') }, dependent: :destroy 
  
    scope(:search, -> (query) { where("title ILIKE?", "%#{query}%") })
  
    def self.search_but_using_class_method(query)
      where("title ILIKE?", "%#{query}%")
    end
  
    def self.get_paginated(search, sort_by_col, current_page, per_page_count)
      where("title ILIKE ? OR description ILIKE ?", "%#{search}%", "%#{search}%").order(Hash[sort_by_col, :desc]).limit(per_page_count).offset(current_page * per_page_count) 
    end
  
    private
  
    def capitalize_title
      self.title.capitalize!
    end
  
    def log_delete_details
      puts "Idea #{self.id} is about to be deleted"
    end

  end
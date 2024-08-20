# frozen_string_literal: true

class Report < ApplicationRecord
  after_save :get_mentions_id
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :active_mentions, class_name: 'Mention', foreign_key: :mentioning_report_id, dependent: :destroy
  has_many :mentioning_reports, through: :active_mentions, source: :mentioned_report

  has_many :passive_mentions, class_name: 'Mention', foreign_key: :mentioned_report_id, dependent: :destroy
  has_many :mentioned_reports, through: :passive_mentions, source: :mentioning_report

  validates :title, presence: true
  validates :content, presence: true

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  def get_mentions_id
    Mention.where(mentioning_report_id: self.id).destroy_all
    urls = self.content.scan(/http:\/\/localhost:3000\/reports\/\d+/)
    if urls.any?
      urls.each do |url|
        id = url.match(/reports\/(\d+)/)[1]
        Mention.create(mentioning_report_id: self.id, mentioned_report_id: id)
      end
    end
  end
end

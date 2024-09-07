# frozen_string_literal: true

class Report < ApplicationRecord
  after_save :update_mentions_for_reports
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :active_mentions, class_name: 'Mention', foreign_key: :mentioning_report_id, dependent: :destroy, inverse_of: :mentioning_report
  has_many :mentioning_reports, through: :active_mentions, source: :mentioned_report

  has_many :passive_mentions, class_name: 'Mention', foreign_key: :mentioned_report_id, dependent: :destroy, inverse_of: :mentioned_report
  has_many :mentioned_reports, through: :passive_mentions, source: :mentioning_report

  validates :title, presence: true
  validates :content, presence: true

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  def update_mentions_for_reports
    Mention.where(mentioning_report_id: id).destroy_all
    matched_id = content.scan(%r{http://localhost:3000/reports/(\d+)})

    matched_id.each do |mentioned_id|
      active_mentions.create!(mentioned_report_id: mentioned_id[0])
    end
  end
end

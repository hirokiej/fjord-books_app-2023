class Mention < ApplicationRecord
  belongs_to :mentioning_report, class_name: 'Reports'
  belongs_to :mentioned_report, class_name: 'Reports'
end

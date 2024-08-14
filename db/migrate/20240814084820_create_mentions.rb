class CreateMentions < ActiveRecord::Migration[7.0]
  def change
    create_table :mentions do |t|
      t.references :mentioning_report, null: false, foreign_key: { to_table: :rports }
      t.references :mentioned_report, null: false, foreign_key: { to_table: :rports }

      t.timestamps
    end
    add_index :mentions, [:mentioning_report_id, :mentioned_report_id], unique: true
  end
end


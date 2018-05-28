class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.text :body
      t.belongs_to :idea, foreign_key: true, index: true
      t.timestamps
    end
  end
end

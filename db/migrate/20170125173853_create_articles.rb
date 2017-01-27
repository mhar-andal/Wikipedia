class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.integer :author_id
      t.integer :category_id
      t.string :submission_status
      t.timestamps
    end
  end
end

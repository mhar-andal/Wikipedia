class CreateSections < ActiveRecord::Migration[5.0]
  def change
    create_table :sections do |t|
      t.integer :article_id
      t.integer :current_revision_id

      t.timestamps
    end
  end
end

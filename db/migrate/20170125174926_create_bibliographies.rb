class CreateBibliographies < ActiveRecord::Migration[5.0]
  def change
    create_table :bibliographies do |t|
      t.integer :article_id
      t.text :reference
      t.string :resource_type

      t.timestamps
    end
  end
end

class CreateCpanels < ActiveRecord::Migration[6.1]
  def change
    create_table :cpanels do |t|

      t.timestamps
    end
  end
end

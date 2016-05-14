class CreateTables < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :phone_num, :null => false
      t.string  :last_ticker, :null => true
      t.string  :subscribed_tickers, :null => true
    end
    add_index :users, :phone_num, unique: true
  end
end

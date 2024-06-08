class AddOwnerToPets < ActiveRecord::Migration[7.1]
  def change
    add_reference :pets, :owner, foreign_key: true, index: true
  end
end

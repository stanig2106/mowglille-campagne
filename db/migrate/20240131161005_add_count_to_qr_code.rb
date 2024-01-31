class AddCountToQrCode < ActiveRecord::Migration[7.0]
  def change
    add_column :qr_codes, :count, :integer, default: 0
    add_column :qr_codes, :offline, :boolean, default: false
  end
end

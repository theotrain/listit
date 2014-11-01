class AddTimeZoneOffsetToItems < ActiveRecord::Migration
  def change
    add_column :items, :time_zone_offset, :decimal, :precision => 5, :scale => 2
  end
end

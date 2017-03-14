if TomifyRecord.connection.table_exists? :settings
  Tomify::CarrierwaveHelper.load_config
  Tomify::EmailHelper.load_config
  Tomify::TimezoneHelper.load_config
end

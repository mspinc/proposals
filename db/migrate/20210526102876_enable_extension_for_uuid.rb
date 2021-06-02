class EnableExtensionForUuid < ActiveRecord::Migration[6.1]
  def change
    enable_extension 'pgcrypto' unless ENV['CIRCLECI']
  end
end

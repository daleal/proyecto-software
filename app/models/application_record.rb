class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :includes_substring, -> (column_name, substring) do
    where (["((#{self.table_name}.#{column_name} LIKE ?) OR (#{self.table_name}.#{column_name} LIKE ?) OR (#{self.table_name}.#{column_name} LIKE ?) OR (#{self.table_name}.#{column_name} LIKE ?))",
    "%#{substring.upcase}%", "%#{substring.downcase}%", "%#{substring.capitalize}%", "%#{substring.titleize}%"])
  end

end

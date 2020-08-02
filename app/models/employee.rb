class Employee < ApplicationRecord
  has_many :responses
  scope :response_joins, -> { joins(:responses) }
  scope :dimension_group, -> (dimension) { group("employees.#{dimension}") }
  scope :search_driver, -> (driver) { response_joins.where(responses: {driver_name: driver}) }
  scope :sel_dimension_and_avg_score, -> (dimension) { select("employees.#{dimension} as dimension, AVG(responses.score) as avg_score") }
end

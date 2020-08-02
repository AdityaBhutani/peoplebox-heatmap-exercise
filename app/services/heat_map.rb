class HeatMap
  def self.department_dimension(dimension)
    result = []
    Response.group(:driver_name).count.keys.each do |driver|
      driver_hash = {}
      driver_hash[:driver] = driver
      driver_hash[:scores] = {}
      Employee.sel_dimension_and_avg_score(dimension).dimension_group(dimension).search_driver(driver).each do |emp|
        driver_hash[:scores]["#{emp.dimension}"] = emp.avg_score.truncate(2)
      end
      result << driver_hash
    end
    result
  end
end

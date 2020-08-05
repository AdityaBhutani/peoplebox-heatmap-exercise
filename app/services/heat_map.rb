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

  def self.department_dimension_2(dimension)
    results = Response.select("responses.driver_name as driver, employees.#{dimension} as dimension, responses.score as score").joins(:employee)
    arr = []

    results.each do |data|
      driver = arr.find{|d| d[:driver] == data.driver}
      if driver.nil?
        _out = { driver: data.driver, scores: {} }
        _out[:scores][data.dimension] = [data.score.to_i]
        arr << _out
      else
        if driver[:scores][data.dimension].present?
          driver[:scores][data.dimension] << data.score.to_i
        else
          driver[:scores][data.dimension] = [data.score.to_i]
        end
      end
    end

    arr.each do |arr_element|
      arr_element[:scores].each do |key, val|
        arr_element[:scores][key] = (val.sum.to_f/val.size).truncate(2)
      end
    end
    arr
  end
end

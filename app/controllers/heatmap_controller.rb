class HeatmapController < ApplicationController
  def index
    params[:dimension] = "department" if Employee.column_names.exclude? params[:dimension]
    # result = HeatMap.department_dimension(params[:dimension])
    result = HeatMap.department_dimension_2(params[:dimension])
    render json: result
  end
end

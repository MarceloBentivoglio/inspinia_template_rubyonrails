class DashboardsController < ApplicationController
  def dashboard_1
    render layout: "old_application"
  end

  def dashboard_2
    render layout: "old_application"
  end

  def dashboard_3
    render layout: "old_application"
    @extra_class = "sidebar-content"
  end

  def dashboard_4
    render :layout => "layout_2"
  end

  def dashboard_4_1
  end

  def dashboard_5
  end

  def dashboard_advalori
    render layout: "layout_advalori"
  end
end

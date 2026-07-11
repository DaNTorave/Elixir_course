defmodule Rect do

  def intersect(
        {:rect, left_top_1, right_bottom_1} = rect1,
        {:rect, left_top_2, right_bottom_2} = rect2
      ) do
    # TODO add your implementation
    unless valid_rect(rect1) do
      raise RuntimeError, "invalid rect 1"
    end

    unless valid_rect(rect2) do
      raise RuntimeError, "invalid rect 2"
    end

    {:point, x1_left, y1_top} = left_top_1
    {:point, x1_right, y1_bottom} = right_bottom_1

    {:point, x2_left, y2_top} = left_top_2
    {:point, x2_right, y2_bottom} = right_bottom_2

    x_overlap = x1_left < x2_right and x2_left < x1_right
    y_overlap = y1_bottom < y2_top and y2_bottom < y1_top

    x_overlap and y_overlap
  end


  def valid_rect({:rect, left_top, right_bottom}) do
    # TODO add your implementatio
    {:point, x1, y1} = left_top
    {:point, x2, y2} = right_bottom
    x1 < x2 and y1 > y2
  end

end

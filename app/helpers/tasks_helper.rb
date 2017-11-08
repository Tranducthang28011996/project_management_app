module TasksHelper
  # board-in-process
  def load_name_status name
    return nil unless name
    name_array = name.split("-")
    if name_array.size >= 2
      name_array.delete_at 0
    end
    name_array.join("_")
  end
end

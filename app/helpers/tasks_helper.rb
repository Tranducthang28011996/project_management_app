module TasksHelper
	def check_task_exists_label? task, label_id
		task.labels.pluck(:id).include? label_id
	end
end

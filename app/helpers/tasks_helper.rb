module TasksHelper
	def check_task_exists_label? task, label_id
		task.labels.pluck(:id).include? label_id
	end

	def check_due_date date
		return "" if date.nil?
		return "btn-danger" if date.past?
		return "btn-warning" if date.today?
		return "btn-success" if date.future?
	end
end

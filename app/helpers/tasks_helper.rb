module TasksHelper
  def priority_badge(priority)
    badge_classes = {
      'high' => "bg-red-100 text-red-800 dark:bg-red-900 dark:text-red-200",
      'medium' => "bg-yellow-100 text-yellow-800 dark:bg-yellow-900 dark:text-yellow-200",
      'low' => "bg-green-100 text-green-800 dark:bg-green-900 dark:text-green-200"
    }

    content_tag :span, priority.capitalize,
      class: "px-2 py-1 text-xs rounded-full #{badge_classes[priority]}"
  end
end
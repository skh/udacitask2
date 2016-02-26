class TodoItem
  include Listable
  include UdaciListErrors
  attr_reader :description, :due, :priority

  def initialize(description, options={})
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    raise InvalidPriorityValue unless ["high", "medium", "low", nil].include? options[:priority]
    @priority = options[:priority]
  end
  def details
    format_description(@description) + "due: " +
    format_date(due: @due) +
    format_priority(@priority)
  end
end

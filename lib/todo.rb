class TodoItem
  include Listable
  include UdaciListErrors
  attr_reader :description, :due, :priority, :type

  def initialize(description, options={})
    @type = "todo"
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    raise UdaciListErrors::InvalidPriorityValue unless ["high", "medium", "low", nil].include? options[:priority]
    @priority = options[:priority]
  end
  def details
    output = format_description(@description) + "due: " +
    format_date(due: @due) +
    format_priority(@priority)
    output
  end
end

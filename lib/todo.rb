class TodoItem
  include Listable
  include UdaciListErrors
  attr_reader :description, :due, :type, :priority

  def initialize(description, options={})
    @type = "todo"
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    set_priority(options[:priority])
  end
  def details
    output = "Todo:\t" + format_description(@description) + "due: " +
    format_date(due: @due) +
    format_priority(@priority)
    output
  end
  def priority=(priority)
    set_priority(priority)
  end
  private
  def set_priority(priority)
    raise UdaciListErrors::InvalidPriorityValue unless ["high", "medium", "low", nil].include? priority
    @priority = priority
  end
end

module Listable
  # Listable methods go here
  def format_description(description)
    "#{description}".ljust(30)
  end
  def format_date(options={})
  	if options[:due]
  		options[:due].strftime("%D")
  	elsif options[:start_date] and options[:end_date]
  		dates = @start_date.strftime("%D") if @start_date
    	dates << " -- " + @end_date.strftime("%D") if @end_date
    	return dates
    else
    	return "N/A"
    end
  end
  def format_priority(priority)
    value = " ⇧".colorize(:red) if priority == "high"
    value = " ⇨".colorize(:yellow) if priority == "medium"
    value = " ⇩".colorize(:green) if priority == "low"
    value = "" if !priority
    return value
  end
end

class UdaciList
  include UdaciListErrors

  attr_reader :title, :items

  @@lists = []

  def initialize(options={})
    @title = options[:title] || "Untitled List"
    @items = []
    @@lists << self
  end
  def add(type, description, options={})
    type = type.downcase
    raise UdaciListErrors::InvalidItemType unless ["todo", "event", "link"].include? type
    @items.push TodoItem.new(description, options) if type == "todo"
    @items.push EventItem.new(description, options) if type == "event"
    @items.push LinkItem.new(description, options) if type == "link"
  end
  def delete(index)
    raise UdaciListErrors::IndexExceedsListSize if index >= @items.length
    @items.delete_at(index - 1)
  end
  def priority(index, priority)
    raise UdaciListErrors::IndexExceedsListSize if index >= @items.length
    # Only Todos have a priority
    raise UdaciListErrors::InvalidItemType unless @items[index - 1].type == 'todo'
    @items[index - 1].priority = priority
  end
  def complete(index)
    raise UdaciListErrors::IndexExceedsListSize if index >= @items.length
    # Only Todos can be completed
    raise UdaciListErrors::InvalidItemType unless @items[index - 1].type == 'todo'
    @items[index -1].completed = true
  end
  def all
    puts ("-" * @title.length).colorize(:yellow)
    puts @title.colorize(:green)
    puts ("-" * @title.length).colorize(:yellow)
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end
  def filter(type)
    filtered_items = items_by_type(type)
    puts ("-" * @title.length).colorize(:yellow)
    puts @title.colorize(:green)
    puts ("-" * @title.length).colorize(:yellow)
    filtered_items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
    if filtered_items.length == 0
      puts "There are no items of type '#{type}'."
    end
  end
  def items_by_type(type)
     @items.select {|i| i.type == type}
  end

  def self.all
    rows = []
    rows << ['List', 'Items total', 'Events', 'Todos', 'Links']
    rows << :separator
    @@lists.each do |list|
      row = []
      row << list.title
      row << list.items.length
      row << list.items_by_type('event').length
      row << list.items_by_type('todo').length
      row << list.items_by_type('link').length
      rows << row
    end
    table = Terminal::Table.new :rows => rows
    puts table
  end
end

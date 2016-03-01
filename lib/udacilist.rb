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
  def all
    puts ("-" * @title.length).colorize(:yellow)
    puts @title.colorize(:green)
    puts ("-" * @title.length).colorize(:yellow)
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end
  def filter(type)
    filtered_items = @items.select {|i| i.type == type}
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

  def self.all
    rows = []
    rows << ['List', 'Items', 'Events', 'Todos', 'Links']
    rows << :separator
    @@lists.each do |list|
      row = []
      row << list.title
      row << 0
      row << 0
      row << 0
      row << 0
      rows << row
    end
    table = Terminal::Table.new :rows => rows
    puts table
  end
end

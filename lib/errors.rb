module UdaciListErrors
  # Error classes go here
  class InvalidItemType < StandardError
  end

  class IndexExceedsListSize < StandardError
  end
end

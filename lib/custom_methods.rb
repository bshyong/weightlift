class Array
  # # Ruby 1.9 method
  # instance method; takes an array of objects
  # and counts them
  def occurence_count
    raise "Instance must be an Array!" unless self.kind_of? Array
    return self.reduce({}) do |t, n|
        t.tap do |s|
          s[n] ||= 0
          s[n] += 1
        end
    end
  end
end
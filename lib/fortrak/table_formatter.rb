module TableFormatter
  def self.max_length_columns(a)
    a.map{|el| el.map(&:length)}.transpose.map(&:max)
  end
  
  def self.format(a, divider = ' ')
    max_lengths = self.max_length_columns(a)
    a.map{ |row| self.generate_row_string(row, max_lengths, divider) }.join("\n")
  end
  
  def self.generate_row_string(row, max_lengths, divider)
    row.inject(divider) do |string, el|
        string += el.ljust(max_lengths.rotate!.last) + divider
    end.strip
  end
end

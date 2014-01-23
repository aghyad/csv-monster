class CSVMonster

  attr_reader :input_file, :delimiter, :output_table_object, :object_attributes

  def initialize(input_file , delimiter)
    @input_file = input_file
    @delimiter = delimiter || ","
    @output_table_object = []
    @object_attributes = extract_the_line_of_attributes
  end

  ### this is the main method to read the file: csv_monster_obj.parse_csv
  def parse_csv
    i=0
    output_matrix = []
    trim_return_carriage(fulltext).each_line do |line|
      output_matrix << trim_line_ends(line).split(delimiter) unless i == 0
      i+=1
    end
    output_matrix.each do |rec|
      temp_hsh = {}
      (0..rec.size-1).each do |i|
        temp_hsh.merge! object_attributes[i] => rec[i]
      end
      @output_table_object << temp_hsh
    end

    output_table_object
  end


protected
  def extract_the_line_of_attributes
    trim_return_carriage(fulltext).each_line do |line|
      return trim_line_ends(line).split(delimiter || ',').map{|x| x.to_s.downcase.to_sym}
    end
  end

  def fulltext
    File.open(input_file).read
  end

  def trim_return_carriage(text)
    text.gsub!(/\r\n?/, "\n")
  end

  def trim_line_ends(text)
    text.gsub!("\n","")
    text.gsub!("\t","")
    text
  end

end

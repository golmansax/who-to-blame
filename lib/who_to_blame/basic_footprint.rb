module WhoToBlame
  class BasicFootprint
    attr_accessor :num_lines, :author, :file_type

    def initialize(author, file_type, num_lines)
      self.num_lines = num_lines
      self.author = author
      self.file_type = file_type
    end

    def as_json(*)
      { author: author, file_type: file_type, num_lines: num_lines }
    end

    def ==(other)
      as_json == other.as_json
    end
  end
end

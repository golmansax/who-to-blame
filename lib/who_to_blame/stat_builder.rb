module WhoToBlame
  class StatBuilder
    attr_accessor :file_types

    def initialize(file_types)
      self.file_types = file_types
    end

    def stats
      file_types.each_with_object({}) do |file_type, memo|
        memo[file_type] = lines_per_author(file_type)
        memo
      end
    end

    private

    def lines_per_author(file_type)
      command = 'git ls-tree --name-only -z -r HEAD | ' \
        "egrep -z -Z -E '\.#{file_type}$' | " \
        'xargs -0 -n1 git blame --line-porcelain | ' \
        'grep "^author " | sort | uniq -c'
      result = `#{command}`

      result.split("\n").each_with_object({}) do |line, memo|
        captures = line.match('^\s*(\d*) author (.*)$').captures
        memo[captures.last] = captures.first.to_i
      end
    end
  end
end

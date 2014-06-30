module WhoToBlame
  class StatBuilder
    attr_accessor :file_extensions

    def initialize(file_extensions)
      self.file_extensions = file_extensions
    end

    def stats
      file_extensions.each_with_object({}) do |file_extension, memo|
        memo[file_extension] = lines_per_author(file_extension)
        memo
      end
    end

    private

    def lines_per_author(file_extension)
      command = 'git ls-tree --name-only -z -r HEAD | ' \
        "egrep -z -Z -E '\.#{file_extension}$' | " \
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

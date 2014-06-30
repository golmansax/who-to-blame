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

      lines_per_author = {}
      result.split("\n").each do |line|
        captures = line.match('^\s*(\d*) author (.*)$').captures
        lines_per_author[captures.last] = captures.first
      end
    end
  end
end

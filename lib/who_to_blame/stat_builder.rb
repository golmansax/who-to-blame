module WhoToBlame

  class StatBuilder

    attr_accessor :file_extensions

    def initialize(file_extensions)
      self.file_extensions = file_extensions
    end

    def get_stats
      file_extensions.reduce({}) do |memo, file_extension|
        command = 'git ls-tree --name-only -z -r HEAD | ' \
          "egrep -z -Z -E '\.#{file_extension}$' | " \
          'xargs -0 -n1 git blame --line-porcelain | ' \
          'grep "^author " | sort | uniq -c'
        result = `#{command}`

        lines_per_author = {}
        result.split('\n').each do |line|
          captures = line.match('^\s*(\d*) author (.*)$').captures
          lines_per_author[captures.last] = captures.first
        end

        memo[file_extension] = lines_per_author
        memo
      end
    end

  end

end

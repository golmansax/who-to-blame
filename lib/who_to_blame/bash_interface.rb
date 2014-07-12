module WhoToBlame
  class BashInterface
    def stats(file_type)
      # command = "git log --before#{date} | head -1 | sed 's/commit //'"

      command = 'git ls-tree --name-only -z -r HEAD | ' \
        "egrep -z -Z -E '\.#{file_type}$' | " \
        'xargs -0 -n1 git blame --line-porcelain | ' \
        'grep "^author " | sort | uniq -c'

      `#{command}`
    end
  end
end

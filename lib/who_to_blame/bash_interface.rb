module WhoToBlame
  class BashInterface
    def stats(file_type)
      command = 'git ls-tree --name-only -z -r HEAD | ' \
        "egrep -z -Z -E '\.#{file_type}$' | " \
        'xargs -0 -n1 git blame --line-porcelain | ' \
        'grep "^author " | sort | uniq -c'

      `#{command}`
    end
  end
end

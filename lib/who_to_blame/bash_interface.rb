module WhoToBlame
  class BashInterface
    def commit_at(date)
      date_time = "#{date}T00:00:00-0700"
      command = "git log --before #{date_time} | head -1 | sed 's/commit //'"
      result = `#{command}`.chomp

      result.present? ? result : nil
    end

    def who_to_blame_for(date, file_type)
      commit = commit_at(date)

      command = "git ls-tree --name-only -z -r #{commit} | " \
        "egrep -z -Z -E '\.#{file_type}$' | " \
        "xargs -0 -n1 git blame #{commit} --line-porcelain -- | " \
        'grep "^author " | sort | uniq -c'

      `#{command}`
    end
  end
end

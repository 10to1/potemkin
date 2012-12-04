require "rugged"
module Potemkin
  class Git

    def self.repository
      @repository ||= Rugged::Repository.new(".")
    end

    def self.last_commit_is_a_tag?

    end

    def self.current_branch
      repository.branches.detect {|b| b.target == repository.head.target}.name
    end

    def self.changelog
      tag = `git describe --abbrev=0 --tags`.strip
      `git cat-file tag #{tag} | sed -e '1,/^$/d'`
    end

  end
end

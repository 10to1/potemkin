require "rugged"
module Potemkin
  class Git

    attr_accessor :repository_path
    def initialize(path = nil)
      @repository_path = path || discover_repo
    end

    def repository
      @repository ||= Rugged::Repository.new(repository_path)
    end

    def current_sha
      repository.head.target
    end

    def current_tag
      tag = tag_for_commit(current_sha)
      tag ? tag.name : nil
    end

    def current_branch
      branch = repository.branches.detect {|b| b.target == repository.head.target}
      branch ? branch.name : nil
    end

    def previous_tag
      commit = repository.lookup(current_sha).parents.first
      while commit && !tag_for_commit(commit.oid)
        commit = commit.parents.first
      end
      commit ? tag_for_commit(commit.oid).name : "<No previous tag>"
    end

    def tag_for_commit(sha)
      tag_ref = repository.refs(/tags/).detect do |ref|
        repository.lookup(ref.target).target.oid == sha
      end
      repository.lookup(tag_ref.target) if tag_ref
    end

    def changelog
      commit = repository.lookup(current_sha).parents.first
      messages = []
      while(commit && tag_for_commit(commit.oid).nil?)
        messages << commit.message.strip
        commit = commit.parents.first
      end
      messages
    end

    def self.discovered
      current_dir = config.project_path
      while current_dir.length > 1 && !Dir.exists?(File.join(current_dir, ".git"))
        current_dir = current_dir.split(File::SEPARATOR)[0...-1].join(File::SEPARATOR)
      end
      Dir.exists?(File.join(current_dir, ".git")) ? new(current_dir) : raise("Not a git repository")
    end

    def self.config
      Potemkin.config
    end

  end
end

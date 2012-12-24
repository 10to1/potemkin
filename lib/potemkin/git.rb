require "rugged"
module Potemkin
  class Git

    attr_accessor :repository_path
    def initialize(path = ".")
      @repository_path = path
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

    def tag_for_commit(sha)
      tag_ref = repository.refs(/tags/).detect do |ref|
        repository.lookup(ref.target).target.oid == sha
      end
      repository.lookup(tag_ref.target) if tag_ref
    end

    def changelog
      commit = repository.lookup(current_sha).parents.first
      messages = []
      while(commit && tag_for_commit(commit.oid).nil?) do
        messages << commit.message.strip
        commit = commit.parents.first
      end
      messages
    end

    def config
      Potemkin.config
    end

  end
end

require "helper"

describe Potemkin::Git do

  before do
    unless File.directory?(FAKE_GIT_REPO)
      `cd #{FAKE_DIR} && tar -xvzf #{FAKE_GIT_TAR}`
    end
    @git  = Potemkin::Git.new(FAKE_GIT_REPO)
  end

  it "should be able to detect the current branch" do
    checkout_master
    assert_equal "master", @git.current_branch
  end

  it "should see the current tag when there is one" do
    checkout_tagged_commit
    assert_equal "0.0.1", @git.current_tag
  end

  it "should return nil for current_tag when there is no tag" do
    checkout_initial_commit
    assert_equal nil, @git.current_tag
  end

  it "should find tags for a commit" do
    assert @git.tag_for_commit(FIRST_TAGGED_COMMIT)
  end

  it "should create a changelog with all the commits betweet to version tags" do
    checkout_last_tagged_commit
    messages = ["Changelog 3", "Changelog 2", "Changelog 1"]
    assert_equal messages, @git.changelog
  end

  it "should be able to find the previous tag" do
    checkout_master
    assert_equal "0.0.2", @git.previous_tag
  end

  it "should not fail when no previous tag" do
    checkout_tagged_commit
    assert_equal "<No previous tag>", @git.previous_tag
  end

  it "should be able to discover the repo when it wasn't found in the project_path" do
    Potemkin::Git.expects(:config).returns(OpenStruct.new(project_path: "#{FAKE_GIT_REPO}/subfolder"))
    assert_equal FAKE_GIT_REPO, Potemkin::Git.discover_repo
  end

  after do
    checkout_master
  end

end

def checkout_master
  system("cd #{FAKE_GIT_REPO} && git checkout master")
end

def checkout_last_tagged_commit
  system("cd #{FAKE_GIT_REPO} && git checkout --detach #{LAST_TAGGED_COMMIT}")
end

def checkout_tagged_commit
  system("cd #{FAKE_GIT_REPO} && git checkout --detach #{FIRST_TAGGED_COMMIT}")
end

def checkout_initial_commit
  system("cd #{FAKE_GIT_REPO} && git checkout --detach #{INITIAL_COMMIT}")
end

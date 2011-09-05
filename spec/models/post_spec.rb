require 'spec_helper'

describe Post do
  it {should belong_to(:user)}
  it {should have_and_belong_to_many(:tags)}
end

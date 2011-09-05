require 'spec_helper'

describe Attendance do
  it {should belong_to(:user)}
  it {should belong_to(:event)}
end

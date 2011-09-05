require 'spec_helper'

describe Event do
  it {should have_many(:attendances)}
  it {should belong_to(:location)}
  it {should belong_to(:organizer)}
end

require 'spec_helper'

describe ProjectPhoto do
  it { should belong_to(:project) }
end

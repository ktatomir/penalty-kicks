require 'spec_helper'

FactoryGirl.factories.map(&:name).each do |factory_name|
  describe "The #{factory_name} factory" do
    it{build(factory_name).should be_valid}
    it{create_list(factory_name, 5).should be_kind_of(Array)}
  end
end
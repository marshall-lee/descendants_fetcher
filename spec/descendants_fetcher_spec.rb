require 'spec_helper'

describe DescendantsFetcher do
  let!(:parent) do
    Class.new do
      extend DescendantsFetcher
    end
  end

  describe 'descendants' do
    subject { parent.descendants }

    it 'should contain itself' do
      should include parent
    end

    describe 'when there are inherited classes' do
      let!(:non_child) { Class.new }
      let!(:child) {  Class.new(parent) }
      let!(:grand_child) { Class.new(child) }

      it 'should contain all the descendants' do
        should contain_exactly parent, child, grand_child
      end
    end
  end

  describe 'subclasses' do
    subject { parent.subclasses }

    describe 'when there are inherited classes' do
      let!(:non_child) { Class.new }
      let!(:child) {  Class.new(parent) }
      let!(:another_child) {  Class.new(parent) }
      let!(:grand_child) { Class.new(child) }

      it 'should contain only children' do
        should contain_exactly child, another_child
      end
    end
  end
end

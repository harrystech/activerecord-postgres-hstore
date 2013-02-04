require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe ActiveRecord::Coders::Hstore do
  describe "#load" do
    subject{ ActiveRecord::Coders::Hstore.new.load(value) }

    context 'when value is nil and we have a default in the constructor' do
      subject{ ActiveRecord::Coders::Hstore.new({'a'=>'a'}).load(nil) }
      it{ should eql({'a'=>'a'}) }
    end

    context 'when value is nil' do
      let(:value){ nil }
      it { should be_nil }
    end

    context 'when value is a hstore' do
      let(:value){ "a=>a" }
      it{ should eql({ 'a' => 'a' }) }
    end
  end

  describe "#dump" do
    subject{ ActiveRecord::Coders::Hstore.new.dump(value) }

    context 'when value is nil and we have a default in the constructor' do
      subject{ ActiveRecord::Coders::Hstore.new({'a'=>'a'}).dump(nil) }
      it{ should eql({'a'=>'a'}.to_hstore) }
    end

    context 'when value is nil' do
      let(:value){ nil }
      it{ should be_nil }
    end

    context "when value is an hstore" do
      let(:value){ {'a' => 'a'} }
      it{ should eql(value.to_hstore) }
    end
  end

  describe ".load" do
    before do
      @parameter = 'b=>b'
      instance = double("coder instance")
      instance.should_receive(:load).with(@parameter)
      ActiveRecord::Coders::Hstore.should_receive(:new).and_return(instance)
    end

    it("should instantiate and call load") do
      ActiveRecord::Coders::Hstore.load(@parameter)
    end
  end

  describe ".dump" do
    before do
      @parameter = {'b' => 'b'}
      instance = double("coder instance")
      instance.should_receive(:dump).with(@parameter)
      ActiveRecord::Coders::Hstore.should_receive(:new).and_return(instance)
    end

    it("should instantiate and call load") do
      ActiveRecord::Coders::Hstore.dump(@parameter)
    end
  end
end

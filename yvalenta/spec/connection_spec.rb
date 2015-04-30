require "spec_helper"

describe 'Connection' do
  let(:connection) { Connection.new }
  let(:regex) { /[0-9a-f]{ 8 }-[0-9a-f]{ 4 }-[0-9a-f]{ 4 }-[0-9a-f]{ 4 }-[0-9a-f]{ 12 }/}

  describe '#add' do

    it 'must return an uuid' do
      id = connection.add(5)
      expect(id).to match(regex)
    end

    it 'must add a new connection to connections hash' do
      previous_count = connection.all.count
      id = connection.add(5)
      expect(connection.all.count).to be > previous_count
    end
  end

  describe '#find' do

    it 'must find a connection in a collection of connections by id' do
      id = connection.add(5)
      expect(connection.find(id)).to be == 5
    end

    it 'calls find with an id' do
      id = connection.add(5)
      expect(connection).to receive(:find).with(id)
      connection.find(id)
    end
  end

  describe '#destroy' do

    it 'must delete a connection from the collection' do
      id = connection.add(5)
      previous_count = connection.all.count
      connection.destroy(id)
      expect(connection.all.count).to be < previous_count
    end

    it 'calls destoy with an id' do

      id = connection.add(5)
      expect(connection).to receive(:destroy).with(id)
      connection.destroy(id)
    end
  end

  describe '#all' do

    it 'must return a hash with the connections' do
      id1 = connection.add(5)
      id2 = connection.add(10)
      expect(connection.all).to include(id1, id2)
      expect(connection.all).to include(id1 => 5, id2 => 10)
    end
  end

  describe '#all_except' do

    it 'must return a hash with the connections with different id' do
      id_to_remove = connection.add(5)
      connection.add(10)
      connection.add(15)
      expect(connection.all_except(id_to_remove)).not_to include(id_to_remove)
    end

    it 'calls all_exept with an id' do
      id = connection.add(5)
      expect(connection).to receive(:all_except).with(id)
      connection.all_except(id)
    end
  end

  describe '#generate_key' do

    it 'must return a UUID key' do
      expect(connection.generate_key).to  match(regex)
    end
  end
end

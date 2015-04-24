require_relative 'client_helper'

describe 'Message' do
  let(:message) { Message.new(code: 200, message: 'Some message') }

  describe 'CODES' do
    it 'should return valid status codes' do
      expect(Message::CODES).to be == %w(100 101 102 200 201 300)
    end
  end

  describe '#valid_code?' do
    it 'should return true if message has a valid code' do
      expect(message.valid_code?).to be == true
    end

    it 'should return false if message has a valid code' do
      message.code = 900
      expect(message.valid_code?).to be == false
    end
  end

  describe '#from_json' do
    it 'should return a new instance of message given a json' do
      json = '{"code":200}'
      expect(Message.from_json(json)).to be_an_instance_of Message
    end
  end

  describe '#build' do
    it 'should return a json formated from a message' do
      message = 'My custom message'
      result = '{"code":200,"message":"My custom message"}'
      expect(Message.build(message)).to be_eql result
    end
  end

  describe '#gess_code' do
    it 'should return 300 if message is /help' do
      expect(Message.gess_code('/help')).to be_eql 300
    end

    it 'should return 300 if message is /list' do
      expect(Message.gess_code('/list')).to be_eql 102
    end

    it 'should return 300 if message does not contains any command' do
      expect(Message.gess_code('Some message')).to be_eql 200
    end
  end
end

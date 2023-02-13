require_relative '../../protobuf/repository'

module ProtoBuf
  describe Repository do
    describe 'message_path_list' do
      it 'メッセージファイルが全て取得できることを確認' do
        repository = ProtoBuf::Repository.new('./spec/fixtures/protobuf/message_path_list')
        path_list = repository.message_path_list

        expect(path_list.length).to eq 2
        expect(path_list[0]).to eq File.expand_path('./spec/fixtures/protobuf/message_path_list/test.proto')
        expect(path_list[1]).to eq File.expand_path('./spec/fixtures/protobuf/message_path_list/test2.proto')
      end
    end
  end
end

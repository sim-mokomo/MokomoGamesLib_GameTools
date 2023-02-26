require_relative '../../protobuf/repository'

module ProtoBuf
  describe Repository do
    describe 'message_path_list' do
      it 'メッセージファイルが全て取得できることを確認' do
        message_list_root_path = './commons/fastlane/spec/protobuf/fixtures/protobuf/message_path_list'
        repository = ProtoBuf::Repository.new(message_list_root_path)
        path_list = repository.message_path_list

        expect(path_list.length).to eq 2
        expect(path_list[0]).to eq File.expand_path(File.join(message_list_root_path, 'test.proto').to_s)
        expect(path_list[1]).to eq File.expand_path(File.join(message_list_root_path, 'test2.proto').to_s)
      end
    end
  end
end

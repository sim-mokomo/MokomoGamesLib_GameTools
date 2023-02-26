require_relative '../../unity/project'

module Unity
  describe Project do
    describe 'root_path' do
      it 'クライアント部分ルートパスを取得できるように' do
        expect(Unity::Project.new('/path/to/').project_root_path).to eq '/path/to/client'
      end
    end
    describe 'assets_path' do
      it 'クライアントのアセットパスを取得できるように' do
        expect(Unity::Project.new('/path/to/').assets_path).to eq '/path/to/client/Assets'
      end
    end
  end
end

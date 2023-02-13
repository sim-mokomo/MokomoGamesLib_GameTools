require_relative '../../system/command/command'
require_relative '../../system/command/custom_option'
require_relative '../../system/command/parser'

describe System::Command::Parser do
  it 'オプションが存在しない状態で期待通りのコマンド文字列が形成されること' do
    parser = System::Command::Parser.new
    commands = []
    command = System::Command::Command.new('command', [])
    commands.push(command)
    command_string = parser.parse(commands)
    expect(command_string).to eq 'command'
  end

  it 'オプションが付きの状態で期待通りのコマンド文字列が形成されること' do
    parser = System::Command::Parser.new
    commands = []
    command = System::Command::Command.new(
      'command',
      [
        System::Command::Option.new('key1', 'option_value1'),
        System::Command::Option.new('key2', 'option_value2')
      ]
    )
    commands.push(command)
    command_string = parser.parse(commands)
    expect(command_string).to eq 'command key1 option_value1 key2 option_value2'
  end

  it '何も設定していない場合は空のコマンドが表示されていること' do
    parser = System::Command::Parser.new
    commands = []
    command = System::Command::Command.new('', [])
    commands.push(command)
    command_string = parser.parse(commands)
    expect(command_string).to eq ''
  end
end

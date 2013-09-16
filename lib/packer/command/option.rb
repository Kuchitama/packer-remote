# coding: utf-8

require 'optparse'

module Packer 

  class Command

    # コマンドライン引数を解析するためのモジュール
    # @author sugamasao
    module Options
    
      # コマンドライン引数の解析を行います
      # @param [Array<String>] argv コマンドライン引数
      # @return [Hash] コマンドライン引数を解析した結果のデータ
      def self.parse!(argv)
        options = {}

        sub_command_parsers = create_sub_command_parsers(options)
        command_parser      = create_command_parser

        # 引数の解析を行う
        begin
          command_parser.order! argv

          options[:command] = argv.shift

          sub_command_parsers[options[:command]].parse! argv
        rescue OptionParser::MissingArgument, OptionParser::InvalidOption, ArgumentError => e
          abort e.message
        end

        options
      end

      # サブコマンド用OptionParserを定義
      # @param  [Hash] options オプションが指定された際に値を保持するためのオブジェクト
      # @return [Hash<OptionParser>]
      def self.create_sub_command_parsers(options)
        # サブコマンドの処理をする際に、未定義のkeyを指定されたら例外を発生させる
        sub_command_parsers = Hash.new do |k, v|
          raise ArgumentError, "'#{v}' is not sub command."
        end

        # サブコマンド用の定義
        sub_command_parsers['run'] = OptionParser.new do |opt|
          opt.banner = 'Usage: run <args>'
          opt.on('-c VAL', '--config=VAL', 'the path to remote configuration json. default = ./config.json') {|v| options[:config] = v }
          opt.on('-p VAL', '--port=VAL',   'server port')    {|v| options[:port]    = v }
          opt.on_tail('-h', '--help', 'Show this message')  {|v| help_sub_command(opt) }
        end

        sub_command_parsers
      end

      # 引数を扱うOptionParserを用意する
      # @return [OptionsParser]
      def self.create_command_parser
        OptionParser.new do |opt|
          sub_command_help = [
            {name: 'run     [-p port] [-c config]',   summary: 'run a packer remote server'},
          ]

          opt.banner = "Usage: #{opt.program_name} [-h|--help] [-v|--version] <command> [<args>]"
          opt.separator ''
          opt.separator "#{opt.program_name} Available Commands:"
          sub_command_help.each do |command|
            opt.separator [opt.summary_indent, command[:name].ljust(40), command[:summary]].join(' ')
          end

          opt.on_head('-h', '--help', 'Show this message') do |v|
            puts opt.help
            exit
          end

          opt.on_head('-v', '--version', 'Show program version') do |v|
            opt.version = Packer::Server::VERSION
            puts opt.ver
            exit
          end
        end
      end

      # サブコマンドのヘルプメッセージを出力してプログラムを終了します
      # @param [OptionParser] parser -h/--helpを処理するサブコマンドのOptionParser
      def self.help_sub_command(parser)
        puts parser.help
        exit
      end

      private_class_method :create_sub_command_parsers, :create_command_parser, :help_sub_command
 
    end
  end
end

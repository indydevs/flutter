# frozen_string_literal: true

require "parser/current"
require "digest/sha1"
require "set"

module Flutter
  class Parser
    attr_reader :signatures

    def initialize(file)
      @signatures = {}
      if File.exist?(file)
        code = File.open(file, "r").read
        @file = File.absolute_path(file)
        @ast = ::Parser::CurrentRuby.parse(code)
        build_signatures_from_source(nil, nil, false)
      end
    end

    def build_signatures_from_source(ast, parent, in_singleton)
      ast ||= @ast
      ast.children.each do |child|
        if child && (child.class == ::Parser::AST::Node)
          if [:class, :module].include?(child.type)
            full_name = parent ? "#{parent}::#{child.location.name.source}" : child.location.name.source
            build_signatures_from_source(child, full_name, false)
          elsif (child.type == :def && in_singleton) || child.type == :defs
            @signatures["#{parent}::#{child.location.name.source}"] =
              Digest::SHA1.hexdigest(child.location.expression.source)
          elsif child.type == :def
            @signatures["#{parent}:#{child.location.name.source}"] =
              Digest::SHA1.hexdigest(child.location.expression.source)
          else
            build_signatures_from_source(child, parent, in_singleton || child.type == :sclass)
          end
        end
      end
    end
  end
end

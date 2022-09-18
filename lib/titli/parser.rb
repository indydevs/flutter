# frozen_string_literal: true

require "parser/current"
require "digest/sha1"

module Titli
  class Parser
    attr_reader :signatures

    def initialize(file)
      code = File.open(file, "r").read
      @ast = ::Parser::CurrentRuby.parse(code)
      @signatures = build_signatures(@ast, nil, false)
    end

    def build_signatures(ast, parent, in_singleton)
      signatures = {}
      # if [:class, :module].include?(ast.type)
      #  parent = ast.location.name.source
      # end
      ast.children.each do |child|
        if child && (child.class == ::Parser::AST::Node)
          if [:class, :module].include?(child.type)
            signatures.update(build_signatures(child,
              parent ? "#{parent}::#{child.location.name.source}" : child.location.name.source, false,))
          elsif (child.type == :def && in_singleton) || child.type == :defs
            signatures["#{parent}::#{child.location.name.source}"] =
              Digest::SHA1.hexdigest(child.location.expression.source)
          elsif child.type == :def
            signatures["#{parent}:#{child.location.name.source}"] =
              Digest::SHA1.hexdigest(child.location.expression.source)
          else
            signatures.update(
              build_signatures(child, parent, in_singleton || child.type == :sclass),
            )
          end
        end
      end
      signatures
    end
  end
end

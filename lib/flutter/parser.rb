# frozen_string_literal: true

require "parser/current"
require "digest/sha1"
require "set"

module Flutter
  class Parser
    attr_reader :signatures

    def initialize(file)
      @signatures = {}
      @targets = Set.new
      if File.exist?(file)
        code = File.open(file, "r").read
        @file = File.absolute_path(file)
        @ast = ::Parser::CurrentRuby.parse(code)
        collect_targets(nil, nil, false)
        build_signatures
      end
    end

    private

    def collect_targets(ast, parent, in_singleton)
      ast ||= @ast
      if [:module, :class].include?(ast.type)
        @targets << ast.location.name.source unless parent
        parent ||= ast.location.name.source
      end
      ast.children.each do |child|
        if child && (child.class == ::Parser::AST::Node)
          if [:class, :module].include?(child.type)
            child_name = child.location.name.source
            full_name = parent && !child_name.start_with?("::") ? "#{parent}::#{child_name}" : child_name
            @targets << full_name
            collect_targets(child, full_name, false)
          else
            # Don't descend into local scopes as those classes/modules are not relevant
            next if [:def, :defs, :block].include?(child.type)

            collect_targets(child, parent, in_singleton || child.type == :sclass)
          end
        end
      end
    end

    def build_signatures
      require_relative @file
      @targets.each do |container|
        instance = Kernel.const_get(container)
        class_methods = (
          instance.methods - Object.methods
        ) + (
          instance.private_methods - Object.private_methods
        )
        instance_methods = (
          instance.instance_methods - Object.instance_methods
        ) + (
          instance.private_instance_methods - Object.private_instance_methods
        )

        @signatures.merge!(class_methods.map do |method|
          ["#{container}::#{method}", source_hash(instance.method(method))]
        end.to_h)
        @signatures.merge!(instance_methods.map do |method|
          ["#{container}:#{method}", source_hash(instance.instance_method(method))]
        end.to_h)
      rescue NameError
        $stderr.puts "failed to load #{container} in #{@file}"
      end
    rescue LoadError
      $stderr.puts "failed to inspect #{@file}"
    end

    def source_hash(callable)
      Digest::SHA1.hexdigest(callable.source)
    rescue MethodSource::SourceNotFoundError
      "<no-source>"
    end
  end
end

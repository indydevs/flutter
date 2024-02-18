# typed: false
require 'ostruct'
module Skee
  module DB
    module Proto
      module Common
        class Doc
          def initialize(doc)
            @doc = doc
            generate_attribute_readers(doc)
          end

          def generate_attribute_readers(doc)
            doc.to_h.each do |key, value|
              define_singleton_method(key) { value }
            end
          end

          def to_h
            @doc.to_h
          end

          def self.all
            @all_docs
          end

          def self.find(id)
            all_docs = all
            doc = all_docs.find do |doc|
              doc.id == id
            end
            self.new(doc) if doc
          end

          def self.find_all(ids:)
            all_docs = all
            docs_array = all_docs.filter do |doc|
              ids.include? doc.id
            end
            docs_array.map do |doc|
              self.new(doc)
            end
          end

          def self.where(fields)
            all_docs = all
            docs_array = all_docs.filter do |doc|
              fields.all? do |key, value|
                doc[key] == value
              end
            end
            docs_array.map do |doc|
              self.new(doc)
            end
          end

          def self.create(fields)
            new_id = rand(0..2**32)
            new_doc = OpenStruct.new(
              id: new_id
            )
            fields.each do |key, value|
              new_doc[key] = value
            end
            all << new_doc
            find(new_doc.id)
          end

          def update(fields)
            fields.each do |key, value|
              @doc[key] = value
            end
            @doc
          end

          def delete
            self.class.all.delete(@doc)
          end

          def self.delete_all
            @all_docs = []
          end
        end
      end
    end
  end
end

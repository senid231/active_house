require_relative '../prepared_statement'

module ActiveHouse
  module Querying
    module Select
      extend ActiveSupport::Concern

      included do
        private :build_select_query_part
      end

      def build_select_query_part
        if !values[:select].empty?
          "SELECT\n#{values[:select].join(",\n")}"
        else
          'SELECT *'
        end
      end

      def initial_values
        super.merge select: []
      end

      def select(*fields)
        dup.select!(*fields)
      end

      def select!(*fields)
        formatted_fields = ActiveHouse::PreparedStatement.format_fields(model_class, fields)
        values[:select] = (values[:select] + formatted_fields).uniq
        self
      end
    end
  end
end

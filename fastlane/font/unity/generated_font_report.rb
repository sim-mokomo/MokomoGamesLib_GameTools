module Font
  module Unity
    class GeneratedFontReport
      # rubocop:disable all
      # @return [String]
      attr_accessor :FontName
      # @return [Integer]
      attr_accessor :PointSize
      # @return [Integer]
      attr_accessor :Padding
      # @return [Array<Integer>]
      attr_accessor :IncludeCharacterList
      # @return [Array<Integer>]
      attr_accessor :MissingCharacterList
      # @return [Array<Integer>]
      attr_accessor :ExcludedCharacterList
      # rubocop:enable all

      def []=(key, value)
        instance_variable_set("@#{key}", value)
      end

      # @return [Boolean]
      def wrong_characters_exists
        @MissingCharacterList.any? || @ExcludedCharacterList.any?
      end
    end
  end
end

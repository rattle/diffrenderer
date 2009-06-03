class DiffRenderer

  class ParagraphBlock
    def self.new(context_change)
      case context_change.action
        when "=" then PlainParagraph
        when "-" then RemovedParagraph
        when "+" then AddedParagraph
        when "!" then ChangedParagraph
      end.new(context_change)
    end

    class HtmlParagraph
      def initialize(content, class_string = "")
        @content = content
        @class_string = class_string
      end

      def to_s
        str = "<p#{@class_string}>\n"
        str << "  " << @content
        str << "\n</p>\n"
      end
    end

    class BaseParagraph
      def initialize(context_change)
        @context_change = context_change
      end

      def to_s
        HtmlParagraph.new(content, html_class_string).to_s
      end
    end
    class PlainParagraph < BaseParagraph
      def html_class_string
        ""
      end

      def content
        @context_change.old_element
      end
    end

    class ClassfulParagraph < BaseParagraph
      def html_class_string
        %Q{ class="#{classes.join(" ")}"}
      end
    end

    class DeletedParagraph < ClassfulParagraph
      def content
        @context_change.old_element
      end
    end

    class RemovedParagraph < DeletedParagraph
      def classes
        %w[ removed ]
      end
    end

    class ReplacedParagraph < DeletedParagraph
      def classes
        %w[ removed replaced ]
      end
    end

    class AddedParagraph < ClassfulParagraph
      def classes
        %w[ added ]
      end
      def content
        @context_change.new_element
      end
    end

    class ChangedParagraph
      include WordRunDiffLCS

      class HtmlText
        class HtmlSpan
          def initialize(content, class_string)
            @content = content
            @class_string = class_string
          end

          def to_s
            %Q{<span class="#@class_string">#@content</span>}
          end
        end

        def initialize(context_change)
          @context_change = context_change
        end

        def to_s
          case @context_change.action
            when "=" then old_text
            when "-" then removed_span
            when "+" then added_span
            when "!" then "#{removed_span} #{added_span}"
          end.to_s
        end

        private

        def old_text
          @context_change.old_element
        end
        def removed_span
          HtmlSpan.new(@context_change.old_element, "removed")
        end

        def added_span
          HtmlSpan.new(@context_change.new_element, "added")
        end
      end

      def initialize(context_change)
        @context_change = context_change
      end

      def to_s
        if significant_change? && !all_additions_or_removals?
          removed_paragraph = ReplacedParagraph.new(@context_change)
          added_paragraph = AddedParagraph.new(@context_change)
          removed_paragraph.to_s + added_paragraph.to_s
        else
          words = word_run_level_sdiff.map { |context_change|
            HtmlText.new(context_change)
          }
          HtmlParagraph.new(words.join(" ")).to_s
        end
      end

      private

      WORD_CHANGE_THRESHOLD = 0.25

      def significant_change?
        count = word_level_sdiff.count { |context_change| context_change.action != "=" }
        count.to_f / word_level_sdiff.length > WORD_CHANGE_THRESHOLD
      end

      def all_additions_or_removals?
        word_level_sdiff.all? { |context_change| context_change.action =~ /^[+=]$/ } ||
          word_level_sdiff.all? { |context_change| context_change.action =~ /^[-=]$/ }
      end

                def word_run_level_sdiff
        word_run_sdiff = WordRunContextChangeSequence.new

        word_level_sdiff.each do |context_change|
          word_run_sdiff << context_change
        end

        word_run_sdiff
      end

      def word_level_sdiff
        Diff::LCS.sdiff(@context_change.old_element.split, @context_change.new_element.split)
      end
    end
  end

end


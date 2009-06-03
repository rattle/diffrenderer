module WordRunDiffLCS
  
  class WordRunContextChange
    attr_reader :action, :old_element, :new_element

    def initialize(change_context)
      @action = change_context.action
      @old_element = change_context.old_element
      @new_element = change_context.new_element
    end

    def merge!(change_context)
      return false unless merge_possible_with?(change_context)
      @old_element << " #{change_context.old_element}" if change_context.old_element
      @new_element << " #{change_context.new_element}" if change_context.new_element
      true
    end

    private

    def merge_possible_with?(other)
      return true if action == other.action
      return true if action == "!" && other.action != "="
      false
    end
  end

  class WordRunContextChangeSequence
    def initialize
      @word_run_context_changes = [ ]
    end

    def <<(diff_lcs_context_change)
      word_run_context_change = WordRunContextChange.new(diff_lcs_context_change)

      if empty?
        @word_run_context_changes << word_run_context_change
      else
        @word_run_context_changes << word_run_context_change unless last.merge!(word_run_context_change)
      end
    end
    def map(&block)
      @word_run_context_changes.map(&block)
    end

    private

    def empty?
      @word_run_context_changes.empty?
    end

    def last
      @word_run_context_changes.last
    end
  end

end

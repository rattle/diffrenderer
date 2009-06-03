require 'rubygems'
gem 'diff-lcs', '~> 1.1', '>= 1.1.2'
require 'diff/lcs'
require 'hpricot'
require 'pp'

require 'word_run_diff_lcs'

%w(paragraph_block).each do |file|
  require File.join(File.dirname(__FILE__), 'diffrenderer', file)
end

class DiffRenderer

  UNWANTED_TAGS = %w[ a ul ol ].freeze

  def initialize(paragraph_list_a, paragraph_list_b)
    @paragraph_list_a, @paragraph_list_b = paragraph_list_a, paragraph_list_b
  end

  def to_html
    diff = Diff::LCS.sdiff(@paragraph_list_a,@paragraph_list_b)
    diff.map { |context_change| ParagraphBlock.new(context_change) }.join
  end

  def self.process_html(h)
    doc = Hpricot(h)

    UNWANTED_TAGS.each { |tag| (doc / tag).remove }
    (doc / "p").map { |elem|
      # Silence "nested" <p> tags as Hpricot does not implicitly close <p> tags
      (elem / "p").each do |e|
        class << e; def inner_text; nil; end; end
      end

      text = elem.inner_text.strip

      (elem / "p").each do |e|
        class << e; remove_method :inner_text; end
      end
      text
    }.reject { |text|
      text == ""
    }
  end

end



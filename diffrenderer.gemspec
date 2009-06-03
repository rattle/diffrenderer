# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{diffrenderer}
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["robl"]
  s.date = %q{2009-06-03}
  s.email = %q{robl[at]monkeyhelper.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "diffrenderer.gemspec",
     "examples/diff-html.rb",
     "examples/diff-text.rb",
     "lib/diffrenderer.rb",
     "lib/diffrenderer/paragraph_block.rb",
     "lib/word_run_diff_lcs.rb",
     "test/diffrenderer_test.rb",
     "test/test_helper.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/monkeyhelper/diffrenderer}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{TODO}
  s.test_files = [
    "test/diffrenderer_test.rb",
     "test/test_helper.rb",
     "examples/diff-text.rb",
     "examples/diff-html.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

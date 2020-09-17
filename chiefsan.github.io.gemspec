Gem::Specification.new do |spec|
  spec.name          = "chiefsan.github.io"
  spec.version       = "0.0"
  spec.authors       = ["Sanjay Seetharaman"]
  spec.email         = ["sanjayms0111@gmail.com"]

  spec.summary       = "chiefsan.github.io Jekyll Theme"
  spec.homepage      = "https://github.com/chiefsan/chiefsan.github.io"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").select { |f| f.match(%r!^(assets|_layouts|_includes|_sass|LICENSE|README)!i) }

  spec.add_runtime_dependency "jekyll", "~> 3.8"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 12.3"
  spec.add_development_dependency "jekyll-paginate-v2", "~> 2.0"
  spec.add_development_dependency "jekyll-seo-tag"
  spec.add_development_dependency "jekyll-sitemap"
  spec.add_development_dependency "kramdown-parser-gfm"
end

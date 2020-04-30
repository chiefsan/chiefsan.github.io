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

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "jekyll-paginate-v2"
end

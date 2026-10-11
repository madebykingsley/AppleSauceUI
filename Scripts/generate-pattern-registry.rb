#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"
require "yaml"

root = File.expand_path("..", __dir__)
pattern_directory = File.join(root, "Docs", "Patterns")
output_path = File.join(pattern_directory, "registry.json")
required = %w[id kind category intent content platforms elements variants avoidWhen].freeze
support_values = %w[preferred supported adapted unsupported].freeze

entries = Dir.glob(File.join(pattern_directory, "*.md")).sort.filter_map do |path|
  source = File.read(path)
  match = source.match(/\A---\s*\n(.*?)\n---\s*\n/m)
  next unless match

  metadata = YAML.safe_load(match[1], permitted_classes: [], aliases: false)
  missing = required.reject { |key| metadata.key?(key) }
  abort "#{path}: missing #{missing.join(', ')}" unless missing.empty?
  abort "#{path}: kind must be pattern" unless metadata["kind"] == "pattern"

  invalid_support = metadata.fetch("platforms").values - support_values
  abort "#{path}: invalid platform support #{invalid_support.join(', ')}" unless invalid_support.empty?

  metadata.merge("documentation" => path.delete_prefix("#{root}/"))
end

registry = {
  "schemaVersion" => 1,
  "generatedFrom" => "Docs/Patterns/*.md",
  "patterns" => entries
}

File.write(output_path, "#{JSON.pretty_generate(registry)}\n")
puts "Generated #{output_path} (#{entries.length} patterns)"

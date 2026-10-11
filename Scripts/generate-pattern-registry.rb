#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"
require "yaml"

root = File.expand_path("..", __dir__)
documentation_directories = [
  File.join(root, "Docs", "Patterns"),
  File.join(root, "Docs", "Elements")
].freeze
output_path = File.join(root, "Docs", "Patterns", "registry.json")
required = %w[id kind category intent content platforms variants avoidWhen].freeze
support_values = %w[preferred supported adapted unsupported].freeze
supported_kinds = %w[pattern element].freeze

entries = documentation_directories.flat_map { |directory| Dir.glob(File.join(directory, "*.md")) }.sort.filter_map do |path|
  source = File.read(path)
  match = source.match(/\A---\s*\n(.*?)\n---\s*\n/m)
  next unless match

  metadata = YAML.safe_load(match[1], permitted_classes: [], aliases: false)
  missing = required.reject { |key| metadata.key?(key) }
  abort "#{path}: missing #{missing.join(', ')}" unless missing.empty?
  abort "#{path}: unsupported kind #{metadata['kind']}" unless supported_kinds.include?(metadata["kind"])
  abort "#{path}: patterns require elements" if metadata["kind"] == "pattern" && !metadata.key?("elements")
  abort "#{path}: elements require anatomy" if metadata["kind"] == "element" && !metadata.key?("anatomy")

  invalid_support = metadata.fetch("platforms").values - support_values
  abort "#{path}: invalid platform support #{invalid_support.join(', ')}" unless invalid_support.empty?

  metadata.merge("documentation" => path.delete_prefix("#{root}/"))
end

registry = {
  "schemaVersion" => 2,
  "generatedFrom" => ["Docs/Patterns/*.md", "Docs/Elements/*.md"],
  "patterns" => entries.select { |entry| entry["kind"] == "pattern" },
  "elements" => entries.select { |entry| entry["kind"] == "element" }
}

File.write(output_path, "#{JSON.pretty_generate(registry)}\n")
puts "Generated #{output_path} (#{registry['patterns'].length} patterns, #{registry['elements'].length} elements)"

# Library component documentation

AppleSauce Patterns and Elements are documented once in Markdown. YAML frontmatter carries the small, stable set of fields that tools need for discovery; the body explains design intent and implementation guidance for people and agents.

All entries require `id`, `kind`, `category`, `intent`, `content`, `platforms`, `variants`, and `avoidWhen`. Patterns also declare their `elements`; Elements declare their semantic `anatomy`. `kind` is either `pattern` or `element`. Platform values use `preferred`, `supported`, `adapted`, or `unsupported`.

Run `Scripts/generate-pattern-registry.rb` after changing component frontmatter. The script validates the required fields, kind-specific fields, and known platform support values before replacing `Docs/Patterns/registry.json`. The generated JSON is an index, not a second authored description; prose remains only in Markdown.

This deliberately narrow convention grows only when demonstrated Patterns or Elements establish a real need. It is not intended to become a universal UI schema.

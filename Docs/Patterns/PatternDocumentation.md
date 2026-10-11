# Pattern documentation

AppleSauce patterns are documented once in Markdown. YAML frontmatter carries the small, stable set of fields that tools need for discovery; the body explains design intent and implementation guidance for people and agents.

Required frontmatter fields are `id`, `kind`, `category`, `intent`, `content`, `platforms`, `elements`, `variants`, and `avoidWhen`. `kind` is currently always `pattern`. Platform values use `preferred`, `supported`, `adapted`, or `unsupported`.

Run `Scripts/generate-pattern-registry.rb` after changing pattern frontmatter. The script validates the required fields and known platform support values before replacing `Docs/Patterns/registry.json`. The generated JSON is an index, not a second authored description; prose remains only in Markdown.

This deliberately narrow convention can grow when a second pattern demonstrates a real need. It is not intended to become a universal UI schema.

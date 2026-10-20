# Migrating existing UI

Use the same screen-driven workflow as reconstruction work:

1. Inspect the current rendered consumer, its actual content and states, relevant references, existing Library components, and representative consumers.
2. Prove the migrated layout with actual strings, artwork, controls, and relevant adaptive configurations while preserving established structure and behavior.
3. Generalize reusable concepts. Decide reuse or extension by comparing anatomy, geometry ownership, interaction, and adaptive behavior. Reusing an asset is distinct from reusing a component.
4. Replace hardcoded visual decisions with existing semantic roles. Add a role only when every existing role is semantically wrong, and never let Style Profile choose structural variants.
5. Preserve Neutral + Standard as the compatibility baseline where practical.
6. Render and verify the final post-migration consumer. Unintended overlap, clipped readable content, incorrect artwork bounds, and inaccessible or unreachable controls block completion and require correction followed by reinspection.

After correctness gates pass, limit ordinary work to one focused cosmetic comparison pass and one grouped correction set, followed by reinspection. If rendering is unavailable, report the migration as **visually unverified** and list the configurations that remain unchecked; compilation alone is not visual verification.

---
name: review-class-1
description: Review code quality and maintainability for reusable modules.
color: "#A855F7"
mode: all
---

## Context

These repositories provide shared, reusable functionality used across multiple projects for the ecological restoration of islands.
They exist to centralize core logic so that analysis workflows depend on well-tested, maintainable components rather than ad hoc implementations.
The review ensures these libraries remain reliable, readable, and stable, since defects or poor design propagate across many dependent projects.
Improving quality and maintainability in this layer strengthens collaboration and reduces long-term technical debt across the organization.

## Tasks

- Review README.md for data analyst accuracy and clarity
- Review AGENTS.md for developer accuracy and clarity
- Validate the presence and correctness of CITATION.cff
- Verify GitHub Actions workflows are correctly configured and passing
- Ensure workflows cover tests, linting, and build steps

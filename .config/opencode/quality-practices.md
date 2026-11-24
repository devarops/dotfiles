# Quality Practices

The maintainability practices that `afk-score` counts and every `*-refactor` command reads. They come from ISO/IEC 5055:2021 and its identical OMG ASCQM 1.1 text.

## Practices

| Practice | Unit | Rule | CWE |
| --- | --- | --- | --- |
| Unstructured and duplicated code | duplicated block | A duplicated block above 10% of the instructions in the instance is one weakness. Unstructured control flow is counted through high cyclomatic complexity; ISO 5055 has no separate rule. | 1041 |
| High cyclomatic complexity | function or method | Cyclomatic complexity above 20 is one weakness. | 1121 |
| Over-parameterization | function or method | More than 7 parameters is one weakness. | 1064 |
| Excessive component size | source file | A source file above 1,000 lines is one weakness. | 1080 |
| Hard-coded literals | initialization statement | An initialization statement with a banned hard-coded literal is one weakness. Single-digit integers and constants are exempt. A statement with several literals still counts once. | 1051, 1052 |
| Uncontrolled dynamic code | dynamic call | One weakness per call to a known dynamic primitive. This rule is local: ISO 5055 names the practice but measures no rule for it. | none |

The dynamic primitives, by language:

- Python: `eval`, `exec`, `compile`, `__import__`, and `importlib.import_module` with a string.
- R: `eval(parse(...))`, `do.call` with a string function name, and `get` with a string.
- Shell: `eval` and a `source` whose path is built from strings.

For another language, count the analogous call that evaluates or imports code built from strings.

## Counting

- Read the files at the given commit, not the working tree. For scoring, the caller gives the commit and the file list.
- Count every instance in those files and sum them. Each instance counts once.
- A listed file that is absent at the commit, because it was added or deleted, is skipped.
- A clean set has no instances; the total can be zero.

## Sources

- ISO/IEC 5055:2021 — https://www.iso.org/standard/80623.html
- OMG ASCQM 1.1, the identical free text — https://www.omg.org/spec/ASCQM/1.1/PDF
- CISQ maintainability, the 29 weaknesses — https://www.it-cisq.org/standards/code-quality-standards-maintainability/
- CISQ coding rules, the CWE list — https://www.it-cisq.org/coding-rules/
- Each CWE identifier at `https://cwe.mitre.org/data/definitions/<id>.html`, replacing `<id>` with the identifier.

# Next-action checks

Canonical source for `update-issue` and the "review starred email" skill. Keep the skill's copy synchronized, or make the skill read this file.

## The next-action checks

These four checks are the canonical definition of a next action. They are copied verbatim into the "review starred email" skill, which applies them before it writes a task. If you change a check here, change it there in the same edit.

A next action passes the next-action checks only when all four are true:
1. Verb + object: the action opens with a verb and its object (what do I do, to what?), and that verb + object describes the literal first move.
   Exception: a bounded wait is a valid first move. A wait qualifies only when the line names what is being waited for, gives a date as DD/Mmm/YYYY, and that date is no more than fourteen days away. A wait that is undated, or dated further out, fails this check.
2. Fits in one sitting: one sitting is 15 to 30 minutes.
3. Where/with what: the action names where it happens and with what (what the user needs in hand). Nothing is missing: no info, decision, or other person is needed first. If something is missing, getting it is the next action.
4. Definition of Done: the action ends with a last sentence in the form "Test: <definition of done>", stating the state that means it is over. That Test passes if the action is done and fails if it is not done. Write the label "Test:" in the language defined below.

A follow-up action is a valid next action. When a task concerns something the user is waiting for from someone else, an action such as "Call Ana at the number in the thread. Test: Ana confirms the proposal is sent" passes all four checks: the other person's answer is not something the user needs in hand in order to make the call. Never replace a follow-up with an action that only checks the inbox.

## Format of a next action
- [ ] <verb + object describing the literal first move, with where and with what>. Test: <definition of done>

(In a Spanish task: - [ ] <acción ...>. Prueba: <definición de terminado>)

## Language

Write the whole line, including the "Test:" label, in the language of the task's own materials. Decide it by this order, first match wins:
1. The language of the existing first line, when it already reads as a sentence.
2. The language of the text below the first line — a summary, a sender or date line, or a block written by another command.
3. The language of the task's title.
4. The language of the conversation.

When the description and the title disagree, follow the description: prose carries more signal than a subject line. A Spanish line ends in "Prueba:". A date inside a bounded wait follows the same rule: 01/Jan/2026 in an English line, 01/ene/2026 in a Spanish one. Never translate a line that is already in the task's language, and never translate a task's existing text at any point — only the line you write.

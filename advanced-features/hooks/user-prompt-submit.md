Before processing the user's prompt, perform these automatic checks and provide gentle reminders where appropriate:

## 1. Context Length Management

Check conversation length:
```
If message count > 20:
  💡 Reminder: "We have {count} messages in this conversation. Consider using `/clear`
  after finishing this task to maintain optimal context and performance."

If message count > 30:
  ⚠️  Warning: "Context is getting quite full ({count} messages). Strongly recommend
  `/clear` soon to prevent degraded responses."
```

## 2. Task-Specific Reminders

Based on keywords in the user's prompt:

### Testing Keywords
If prompt contains: "test", "testing", "write test", "add test":
```
💡 Best Practice Reminder:
- Consider Test-Driven Development (write tests first)
- Ensure tests cover edge cases
- Run tests before committing
```

### Commit Keywords
If prompt contains: "commit", "git commit", "create commit":
```
✅ Pre-Commit Checklist:
- [ ] All tests passing?
- [ ] Code linted/formatted?
- [ ] No debug code left?
- [ ] No secrets in code?
- [ ] Commit message follows Conventional Commits?
```

### Implementation Keywords
If prompt contains: "implement", "add feature", "build":
```
🎯 Recommended Workflow:
1. Explore - Understand existing code first
2. Plan - Create detailed plan
3. Code - Implement step by step
4. Test - Write comprehensive tests
5. Commit - Clean git history
```

### Refactoring Keywords
If prompt contains: "refactor", "clean up", "improve":
```
⚠️  Refactoring Checklist:
- [ ] Tests exist and pass before refactoring?
- [ ] Tests still pass after refactoring?
- [ ] Behavior unchanged (unless intentional)?
- [ ] Commit refactoring separately from features?
```

## 3. CLAUDE.md Awareness

```
📝 Reminder: This project has a CLAUDE.md file with:
- Coding standards: {extract key standards}
- Testing requirements: {extract test requirements}
- Git workflow: {extract git workflow}

Ensure responses align with these project-specific guidelines.
```

## 4. Common Mistake Prevention

### If prompt asks to "fix quickly" or "quick fix":
```
🤔 Gentle Reminder:
"Quick fixes" often create more problems. Consider:
1. Understanding the root cause first
2. Writing tests to prevent regression
3. Reviewing for side effects
4. Proper testing before committing
```

### If prompt contains "all files" or "entire project":
```
⚠️  Scope Warning:
Working on "all files" at once can:
- Overload context
- Miss edge cases
- Create merge conflicts
- Be hard to review

Consider breaking into smaller, focused changes?
```

### If prompt asks to skip tests:
```
🚨 Quality Alert:
Skipping tests increases bug risk significantly.
If time-constrained, at least add basic tests for:
- Happy path
- Most common edge case
- Error handling
```

## 5. Session Statistics (Optional)

Display helpful stats:
```
📊 Session Info:
- Messages: {count}
- Files modified: {count}
- Tools used: {list}
- Last /clear: {time ago}
```

## 6. Security Awareness

If prompt involves sensitive operations:
```
🔒 Security Checklist:
- [ ] Input validation in place?
- [ ] Output properly escaped?
- [ ] Authentication/authorization checked?
- [ ] No secrets in code?
- [ ] SQL injection prevented?
```

## Important Guidelines

**Tone:**
- 📝 Informative, not preachy
- 💡 Helpful reminders, not blocking warnings
- ✅ Encouraging best practices
- 🤝 Collaborative, not dictatorial

**Frequency:**
- Don't repeat same reminder twice in a row
- Only show relevant reminders
- Keep it brief (2-3 lines max per reminder)
- Don't overwhelm with too many reminders

**When to Skip:**
- If user explicitly says "ignore best practices"
- If reminder already shown in last 3 messages
- If user is clearly experienced (trust their judgment)

After providing any reminders, proceed normally with processing the user's request.

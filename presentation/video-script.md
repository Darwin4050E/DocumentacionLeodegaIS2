# Video script (English, max. 8 minutes)

## Segments

| # | Segment | Speaker | Time |
|---|---|---|---|
| 1 | System and architecture (components, deployment) | | |
| 2 | Goals of Sprints 1 and 2 | | |
| 3 | High-risk stories selected from the risk matrix | | |
| 4 | Test design technique and justification | | |
| 5 | Live test cases (minimum 3) | | |
| 6 | Results summary | | |

## Johao – segments 3 and 4 (≈ 2 min)

> Draft. Replace every `[...]` with real data from the risk matrix (Section 4).

**High-risk stories (≈ 1 min)**

"Our test plan is risk-based. We reused the risk matrix from Software Engineering I and rated each
story by probability and impact, from one to three. The product gives a score from one to nine,
and anything scoring six or more is high risk.

In Sprints 1 and 2 the high-risk stories were [story A] and [story B]. [Story A] scored [P × I]
because [why it is likely to fail] and [why a failure hurts the client]. [Story B] scored [...]
because [...].

High-risk stories get a test case for every acceptance criterion, at unit, integration and
functional level. Medium-risk stories only get the main flow and one negative case, and low-risk
ones a smoke check, because with two sprints we had to put our time where failures are both likely
and costly."

**Test design technique (≈ 1 min)**

"To design the cases we used [boundary value analysis / equivalence partitioning / a decision
table]. For example, in [story], the field [field] accepts [valid range]. So we tested [min],
[max], and the values just outside, [min − 1] and [max + 1], which are cases [TC-IDs]. We chose
this technique because most defects in [this kind of input] appear at the edges of the range, and
it gives us few cases with high defect-finding power. Geovanny will now run some of these cases
live."

## Test design technique

Technique:

Justification:

## Live test cases

| Case ID | Story / criterion | Input | Expected | Actual | Pass / Fail |
|---|---|---|---|---|---|
| | | | | | |
| | | | | | |
| | | | | | |

At least one case must be invalid, exceptional or a boundary value.

---
title: Code Review
---

[Index](index.md)

## Code Review Process

**Submitter**

* Get the best reviewer
    * For critical services, minimum of 2 Subject Matter Expert (SME) and related manager
* Prepare good MR/PR
    * Separate MR for separate topics (refactoring/feature/bugfix)
    * MR/PR have ticket story on title
    * Write description, include resources if needed (SAD/blueprint/MoM)
* Small MR/PR
    * Address just one thing, one specific feature instead of all features
    * Discuss with reviewer what they think is "small" enough
    * Make sure system will work well even if MR/PR is merged
    * Not too small to difficult to understand the implications
    * No specific rules about LoC, 80 is okay, 1200 is not okay. 200 is okay if on 1 file, not okay if on 500 files.

**Reviewer**

* Ask questions during review
    * Size: small enough?
    * Design: well designed? appropriate?
    * Functionality: behave correctly as intended? Match ticket detail?
    * Complexity: can it be easily understood?
    * Performance: fast enoun? query indexed correctly? proper data structure? scalable to high traffic?
    * Tests: well designed test case?
    * Readability: variable name good? comments clear and useful?
    * Style: does the code follow our guidelines?
    * Documentation: all relevant document updated? correctly match the documentation?
* Review testing
    * Not only happy path
    * Assert state changes
* Use code coverage drop prevention
* Auto reject big MR/PR

**Don't know or can't found SME to review MR/PR? Escalate to manager**

**Example of bad MR/PR**

* MR/PR size violation
    * Problems
        * Change multiple repos at 1 MR/PR, multiple purposes too
    * Suggestion
        * Create MR/PR per repo
        * Use stacked MR/PR
* MR violating one purpose at a time
* MR too complex
* MR too big

**Considerations when rejecting MR/PR**

* Communicate the reason well
* Explain how the submitter can make the MR/PR better

**No perfect MR/PR or reviewer**

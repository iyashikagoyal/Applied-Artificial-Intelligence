 Applied AI project III
Loan Application Evaluation Using Bayesian Network
Abstract: This Bayesian network is created using Netica to evaluate a loan application of a customer. It acts as an pre - evaluating system for loan applying users. In this system, I have considered some of the rules which lenders consider while evaluating a loan application. This will help applicants to see if there loan-application will be approved or rejected.
Features: I have considered the following attributes to evaluate the loan application. Independent Variables:
1. Length at Residence
• Less Than 5 years
• Between 5 to 10 years • More than 10 years
2. Housing Status
• Personally Owned
• On Loan
3. Credit History
• Less Than 700
• More Than 700
4. Age
• Less Than 20
• Between 20-40
• More Than 40
5. Length at current employment • Less than 2 years
• Between 2 to 7 years
• More than 7 years
6. Job status
• Awesome
• Average
• Bad
7. Collateral
• Present
• Absent
8. Savings
• Good
• Bad
• Average
9. Reputation
• Good
• Bad

 10. Loan amount • High
• Low
• Average 11.Loan purpose • Authentic
• Non authentic 12.Loan duration
• Less than 5 years • More than 5 years
Once all the independent variables are known, the dependent variables are calculated. Dependent variables
1. Financial stability - calculated from housing quality, employment quality.
• Good
• Bad
2. Employment quality - from length at current employment, job status.
• Good
• Bad
3. Housing quality - length at residence, housing status
• Good
• Bad
4. Credit quality - credit history, age
• Good
• Bad
5. Assets- collateral , savings
• Good
• Bad
6. Credit worthiness - credit quality, financial stability, employment status, assets, reputation • Good
• Bad
7. Loan decision - credit worthiness, loan amount, loan purpose, loan duration
• Yes
• No
With all the attributes and their values, the loan decision is given.

 Test Case:
Usage: Open it in netica and play with the probabilities to see the different results.

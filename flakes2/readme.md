 Applied Artificial Intelligence Project - 2
Domain: Loan Evaluation Engine (LEE)
Abstract:
This is a fuzzy based system. It acts as an pre - evaluating system for loan applying users. In this system, I have considered some of the rules which lenders consider while evaluating a loan application. This will help applicants to see if there loan-application will be approved or rejected.
Features:
This system was designed to interact with the user by letting him enter the parameters, it then computes the final result of the application. The various inputs to the system are:
• Income 
• Credit-score 
• Required loan-amount 
• Time period for returning the loan.
• Years in employment
There are 3 fuzzy variables. • Credit-score :
• The input range is (0- 850).
• It is divided into low, medium, high where low is a Z fuzzy set, medium is a
triangle fuzzy set, and high is S fuzzy set. • Years in employment
• The input range is (0- 25).
• It is divided into low, medium, high where low is a Z fuzzy set, medium is a
triangle fuzzy set, and high is S fuzzy set. • Income
• The input range is (0- 3000).
• It is divided into low, medium, high where low is a Z fuzzy set, medium is a
triangle fuzzy set, and high is S fuzzy set.
Once we get all the inputs, we now run the module. The structure of the system:

 Knowledge base: The Knowledge base of the system consists of the following: Facts:
Questions: This consists of questions. The questions have an id to distinguish them type , which specifies the type of expected answer. The various questions are:
What is your income?  
What is the total experience?
What is your credit-score?  
In how many years will you repay the loan? What is the loan amount required?
TestCases
  
   

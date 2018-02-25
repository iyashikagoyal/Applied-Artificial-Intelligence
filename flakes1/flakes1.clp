;Loan application evaluation

;Templates

(deftemplate applicant
(slot income (default 0))
(slot collateral (default 0))
(slot credit-score (default 0))
(slot time-period (default 0))
(slot loan-amount (default 0)))

(deftemplate loan-check (slot rating (default 0)))
(deftemplate sufficient-collateral (slot rating (default 0)))
(deftemplate risk (slot rating (default 0)))
(deftemplate payment-ability (slot rating (default 0) ))
(deftemplate question (slot text) (slot type) (slot ident))
(deftemplate answer (slot ident) (slot text))
(deftemplate final-result (slot text))



;Functions to interact with the user

(deffunction ask-user (?question)
"Ask a question, and return the answer"
(printout t ?question " ")
(return (read)))

;Module to assert the answers given by the user
;Rule1
;To ask the questions

(defmodule ask)
(defrule ask::ask-question-by-id
"Ask a question and assert the answer"
(declare (auto-focus TRUE))
(MAIN::question (ident ?id) (text ?text) (type ?type))
(not (MAIN::answer (ident ?id)))
?ask <- (MAIN::ask ?id)
=>
(bind ?answer (ask-user ?text ?type))
(assert (MAIN::answer (ident ?id) (text ?answer)))
(retract ?ask)
(return))

;Startup module
;Rule2
;Welcome the applicant

(defmodule app-startup)
(defrule welcome
=>
(printout t "Start your Loan Application!" crlf)
(printout t "Type your name and press Enter> ")
(bind ?name (read))
(printout t "Let us begin " ?name "." crlf)
(printout t "Please provide the required information." crlf))

;Questions Facts

(deffacts questions
"The questions that are asked to the user by the system."
(question (ident income) (type number)
(text "What is your income ?"))
(question (ident collateral) (type number)
(text "What is the total value of collateral? "))
(question (ident credit-score) (type number)
(text "What is your credit-score?"))
(question (ident time-period) (type number)
(text "In how many years will you re-pay the loan?"))
(question (ident loan-amount) (type number)
(text "What is the loan amount required?")))

;Module requesting details and asserting the answers

(defmodule request-details)
;Rule3
(defrule request-income
=>
(assert (ask income)))
;Rule4
(defrule request-collateral
=>
(assert (ask collateral)))
;Rule5
(defrule request-credit-score
=>
(assert (ask credit-score)))
;Rule6
(defrule request-time-period
=>
(assert (ask time-period)))
;Rule7
(defrule request-loan-amount
=>
(assert (ask loan-amount)))

;Rule8
;Assert all the details as facts

(defrule assert-applicant-fact
(answer (ident income) (text ?i))
(answer (ident collateral) (text ?co))
(answer (ident credit-score) (text ?cs))
(answer (ident time-period) (text ?t))
(answer (ident loan-amount) (text ?l))
=>
(assert (applicant (income ?i) (collateral ?co) (credit-score ?cs) (time-period ?t) (loan-amount ?l))))

;Modules containing the rules that determine whether the loan application is approved or rejected
;Rule9

(defmodule loan-application)
(defrule check-amount
(applicant (loan-amount ?l))
=>
(if (< ?l 10000000) then
(assert (loan-check (rating 1)))
else
(assert (loan-check (rating 0)))))

;Rule10
;Checking if there is sufficient collateral value

(defrule check-sufficient-collateral
(applicant (loan-amount ?l)
(collateral ?co))
=>
(if (< ?l ?co) then
(assert (sufficient-collateral (rating 1)))
else
(assert (sufficient-collateral (rating 0)))))

;Rule11
;Checking the credit score of the applicant

(defrule check-credit
(applicant (credit-score ?cs))
=>
(if (and (> ?cs 599) (< ?cs 851)) then
(assert (risk (rating 1)))
else
(assert (risk (rating 0)))))
    
;Rule12
;Checking if the applicant is able to pay his monthly installments        

(defrule check-payment-ability
(applicant (loan-amount ?l)
(income ?i)
(time-period ?t))
=>
(bind ?number-of-installments (* ?t 12))
(bind ?income-percent (* ?i .6))
(bind ?monthly-installment (/ (* ?l .01 (** (+ 1 .01) ?number-of-installments)) (- (** (+ 1 .01) ?number-of-installments) 1)))
(if (> ?income-percent ?monthly-installment) then
(assert (payment-ability (rating 1)))
else
(assert (payment-ability (rating 0)))))


;Rule13
;Considering sufficient-collateral, ability-to-payment, credit history all together to check eligibilty

(defrule check-eligibilty
(sufficient-collateral (rating ?r1))
(risk (rating ?r2))
(payment-ability (rating ?r3))
(loan-check (rating ?r4))
=>
(bind ?total (+ ?r1 ?r2 ?r3 ?r4))
(if (eq ?total 4) then
(assert (final-result (text "Congratulations. Your loan is approved.")))
else
(assert (final-result (text "Sorry, Your loan is not approved.")))))

;Module that contains the rules to print out the final result of the evaluation
;Rule14
;Print the results.
(defmodule result)
(defrule print-result
?p1 <- (final-result (text ?t))
=>
(printout t ?t crlf crlf))
 


;Function to run the various modules of the application in the correct order

(deffunction run-application ()
(reset)
(focus app-startup request-details loan-application result)
(run))

;Run the above function in a loop to get back the prompt every time we have to enter the values for another candidate or re-run the program

(while TRUE
(run-application))

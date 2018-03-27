;Loan application evaluation

;Fuzzy Variables

(import nrc.fuzzy.*)

(import nrc.fuzz.jess.*)



(deftemplate employment
    "Auto-generated"
	(declare (ordered TRUE)))

(deftemplate income
    "Auto-generated"
    (declare (ordered TRUE)))

(deftemplate credit-score
    "Auto-generated"
    (declare (ordered TRUE)))



(defglobal ?*employment* = 
    (new FuzzyVariable "employment" 0.0 25.0))
(defglobal ?*income* =
    (new FuzzyVariable "income" 0.0 3000.0 ))
(defglobal ?*credit-score* =
    (new FuzzyVariable "credit-score" 0.0 850.0 ))
(defglobal ?*rating* =
    (new nrc.fuzzy.FuzzyVariable "rating" 0.0 10.0 ))


;Def RULE1

(defrule MAIN::init-FuzzyVariables
    (declare (salience 100))
    (initial-fact)
=>
(load-package nrc.fuzzy.jess.FuzzyFunctions)

;Primary Terms

(?*employment* addTerm "low" (new ZFuzzySet 6.00 13.00))
(?*employment* addTerm "medium" (new nrc.fuzzy.TriangleFuzzySet 6.00 13.00 19.00))
(?*employment* addTerm "high" (new SFuzzySet 13.00 19.00))

(?*income* addTerm "low" (new ZFuzzySet 750.00 1500.00))
(?*income* addTerm "medium" (new nrc.fuzzy.TriangleFuzzySet 750.00 1500.00 2250.00))
(?*income* addTerm "high" (new SFuzzySet 1500.00 2250.00))

(?*credit-score* addTerm "low" (new ZFuzzySet 300.00 450.00))
(?*credit-score* addTerm "medium" (new nrc.fuzzy.TriangleFuzzySet 300.00 450.00 700.00))
(?*credit-score* addTerm "high" (new SFuzzySet 450.00 700.00))


(?*rating* addTerm "low" (new ZFuzzySet 3.0 5.0))
(?*rating* addTerm "medium" (new PIFuzzySet 6.0 4.0))
(?*rating* addTerm "high" (new SFuzzySet 7.0 10.0))

)


;Startup module
;Rule2
;Welcome the applicant


(defrule welcome
    (declare (salience 50))
=>
(printout t "Start your Loan Application!" crlf)
(printout t "Type your name and press Enter> ")
(bind ?name (read))
(printout t "Let us begin " ?name "." crlf)
(printout t "Please provide the required information." crlf))

;Initialization


(defrule assert-answers "initialization"
=>
    
    (printout t "What is your income(0-3000 usd) ? ")
    (bind ?income-value (float (readline t)))
	(printout t "How many years of total experience of job does the candidate have(0-25)? ")
    (bind ?employment-value (float (readline t)))
    (printout t "What is your credit-score value(0-850)? ")   
    (bind ?credit-score-value (float (readline t)))
    (printout t "What is the loan amount required? ")
    (bind ?loan-value (float (readline t)))


   (assert(theIncome (new nrc.fuzzy.FuzzyValue ?*income* (new SingletonFuzzySet ?income-value))))
   (assert(theEmployment (new nrc.fuzzy.FuzzyValue ?*employment* (new SingletonFuzzySet ?employment-value))))
   (assert(theCreditScore (new nrc.fuzzy.FuzzyValue ?*credit-score* (new SingletonFuzzySet ?credit-score-value))))
	(assert(theloan ?loan-value)))


(defrule r1 ;"low theEmployment & low theIncome & low theCreditScore => rating very low or low"
    (theEmployment ?e &: (fuzzy-match ?e "low"))
    (theIncome ?i &: (fuzzy-match ?i "low"))
    (theCreditScore ?c &: (fuzzy-match ?c "low"))
=>
    
    (assert(theRating (new nrc.fuzzy.FuzzyValue ?*rating* "very low or low"))))

(defrule r2 ;"low theEmployment & high theIncome & low theCreditScore => rating low or medium or high"
    (theEmployment ?e &: (fuzzy-match ?e "low"))
    (theIncome ?i &: (fuzzy-match ?i "high"))
    (theCreditScore ?c &: (fuzzy-match ?c "low"))
=>
   
    (assert(theRating (new nrc.fuzzy.FuzzyValue ?*rating* "low or medium or high"))))

(defrule r3 ;"low theEmployment & medium theIncome & low theCreditScore => rating low or medium"
    (theEmployment ?e &: (fuzzy-match ?e "low"))
    (theIncome ?i &: (fuzzy-match ?i "medium"))
    (theCreditScore ?c &: (fuzzy-match ?c "low"))
=>
   
    (assert(theRating (new nrc.fuzzy.FuzzyValue ?*rating* "low or medium"))))

(defrule r4 ;"high theEmployment & high theIncome & low theCreditScore=> rating high or medium or low"
    (theEmployment ?e &: (fuzzy-match ?e "high"))
    (theIncome ?i &: (fuzzy-match ?i "high"))
    (theCreditScore ?c &: (fuzzy-match ?c "low"))
=>
  
    (assert(theRating (new nrc.fuzzy.FuzzyValue ?*rating* "high or medium or low"))))

(defrule r5 ;"high theEmployment & low theIncome & low theCreditScore => rating high or medium or low"
    (theEmployment ?e &: (fuzzy-match ?e "high"))
    (theIncome ?i &: (fuzzy-match ?i "low"))
    (theCreditScore ?c &: (fuzzy-match ?c "low"))
=>
   
    (assert(theRating (new nrc.fuzzy.FuzzyValue ?*rating* "high or medium or low"))))

(defrule r6 ;"high theEmployment & medium theIncome & low theCreditScore=> rating low or medium or high"
    (theEmployment ?e &: (fuzzy-match ?e "high"))
    (theIncome ?i &: (fuzzy-match ?i "medium"))
    (theCreditScore ?c &: (fuzzy-match ?c "low"))
=>
    
    (assert(theRating (new nrc.fuzzy.FuzzyValue ?*rating* "high or medium or low"))))

(defrule r7 ;"medium theEmployment & high theIncome & low theCreditScore=> rating low or medium or high"
    (theEmployment ?e &: (fuzzy-match ?e "medium"))
    (theIncome ?i &: (fuzzy-match ?i "high"))
    (theCreditScore ?c &: (fuzzy-match ?c "low"))
=>

    (assert(theRating (new nrc.fuzzy.FuzzyValue ?*rating* "low or medium or high"))))

(defrule r8 ;"medium theEmployment & medium theIncome & low theCreditScore=> rating low or medium"
    (theEmployment ?e &: (fuzzy-match ?e "medium"))
    (theIncome ?i &: (fuzzy-match ?i "medium"))
    (theCreditScore ?c &: (fuzzy-match ?c "low"))
=>
    (assert(theRating (new nrc.fuzzy.FuzzyValue ?*rating* " low or medium "))))

(defrule r9 ;"medium theEmployment & low theIncome & low theCreditScore=> rating medium or low"
    (theEmployment ?a &: (fuzzy-match ?a "medium"))
    (theIncome ?i &: (fuzzy-match ?i "low"))
    (theCreditScore ?c &: (fuzzy-match ?c "low"))
=>

    (assert(theRating (new nrc.fuzzy.FuzzyValue ?*rating* "medium or low"))))

(defrule r10 ;"low theEmployment & low theIncome & medium theCreditScore=> rating very low or low or medium"
    (theEmployment ?e &: (fuzzy-match ?e "low"))
    (theIncome ?i &: (fuzzy-match ?i "low"))
    (theCreditScore ?c &: (fuzzy-match ?c "medium"))
=>

    (assert(theRating (new nrc.fuzzy.FuzzyValue ?*rating* "very low or low or medium"))))

(defrule r11 ;"low theEmployment & high theIncome  & medium theCreditScore=> rating low or medium or high"
    (theEmployment ?e &: (fuzzy-match ?e "low"))
    (theIncome ?i &: (fuzzy-match ?i "high"))
    (theCreditScore ?c &: (fuzzy-match ?c "medium"))
=>

    (assert(theRating (new nrc.fuzzy.FuzzyValue ?*rating* "low or medium or high"))))

(defrule r12 ;"low theEmployment & medium theIncome  & medium theCreditScore=> rating low or medium"
    (theEmployment ?e &: (fuzzy-match ?e "low"))
    (theIncome ?i &: (fuzzy-match ?i "medium"))
    (theCreditScore ?c &: (fuzzy-match ?c "medium"))
=>

    (assert(theRating (new nrc.fuzzy.FuzzyValue ?*rating* "low or medium"))))

(defrule r13 ;"high theEmployment & high theIncome  & medium theCreditScore=> rating high or medium"
    (theEmployment ?e &: (fuzzy-match ?e "high"))
    (theIncome ?i &: (fuzzy-match ?i "high"))
    (theCreditScore ?c &: (fuzzy-match ?c "medium"))
=>
   
    (assert(theRating (new nrc.fuzzy.FuzzyValue ?*rating* "high or medium"))))

(defrule r14 ;"high theEmployment & low theIncome  & medium theCreditScore=> rating high or medium or low"
    (theEmployment ?e &: (fuzzy-match ?e "high"))
    (theIncome ?i &: (fuzzy-match ?i "low"))
    (theCreditScore ?c &: (fuzzy-match ?c "medium"))
=>

    (assert(theRating (new nrc.fuzzy.FuzzyValue ?*rating* "high or medium or low"))))

(defrule r15 ;"high theEmployment & medium theIncome  & medium theCreditScore=> rating low or medium or high"
    (theEmployment ?e &: (fuzzy-match ?e "high"))
    (theIncome ?i &: (fuzzy-match ?i "medium"))
    (theCreditScore ?c &: (fuzzy-match ?c "low"))
=>
 
    (assert(theRating (new nrc.fuzzy.FuzzyValue ?*rating* "high or medium or low"))))

(defrule r16 ;"medium theEmployment & high theIncome  & medium theCreditScore=> rating medium or high"
    (theEmployment ?e &: (fuzzy-match ?e "medium"))
    (theIncome ?i &: (fuzzy-match ?i "high"))
    (theCreditScore ?c &: (fuzzy-match ?c "medium"))
=>
    
    (assert(theRating (new nrc.fuzzy.FuzzyValue ?*rating* " medium or high"))))

(defrule r17 ;"medium theEmployment & medium theIncome  & medium theCreditScore=> rating medium"
    (theEmployment ?e &: (fuzzy-match ?e "medium"))
    (theIncome ?i &: (fuzzy-match ?i "medium"))
    (theCreditScore ?c &: (fuzzy-match ?c "medium"))
=>
    
    (assert(theRating (new nrc.fuzzy.FuzzyValue ?*rating* " medium "))))

(defrule r18 ;"medium theEmployment & low theIncome  & medium theCreditScore=> rating medium or low"
    (theEmployment ?e &: (fuzzy-match ?e "medium"))
    (theIncome ?i &: (fuzzy-match ?i "low"))
    (theCreditScore ?c &: (fuzzy-match ?c "medium"))
=>
 
    (assert(theRating (new nrc.fuzzy.FuzzyValue ?*rating* "medium or low"))))

(defrule r19 ;"low theEmployment & low theIncome  & high theCreditScore=> rating low or medium or high"
    (theEmployment ?e &: (fuzzy-match ?e "low"))
    (theIncome ?i &: (fuzzy-match ?i "low"))
    (theCreditScore ?c &: (fuzzy-match ?c "high"))
=>
    
    (assert(theRating (new nrc.fuzzy.FuzzyValue ?*rating* " low or medium or high"))))

(defrule r20 ;"low theEmployment & high theIncome & high theCreditScore=> rating low or medium or high"
    (theEmployment ?e &: (fuzzy-match ?e "low"))
    (theIncome ?i &: (fuzzy-match ?i "high"))
    (theCreditScore ?c &: (fuzzy-match ?c "high"))
=>
   
    (assert(theRating (new nrc.fuzzy.FuzzyValue ?*rating* "low or medium or high"))))

(defrule r21 ;"low theEmployment & medium theIncome & high theCreditScore=> rating low or medium or high"
    (theEmployment ?e &: (fuzzy-match ?e "low"))
    (theIncome ?i &: (fuzzy-match ?i "medium"))
    (theCreditScore ?c &: (fuzzy-match ?c "high"))
=>
    
    (assert(theRating (new nrc.fuzzy.FuzzyValue ?*rating* "low or medium or high"))))

(defrule r22 ;"high theEmployment & high theIncome & high theCreditScore=> rating very high or high"
    (theEmployment ?e &: (fuzzy-match ?e "high"))
    (theIncome ?i &: (fuzzy-match ?i "high"))
    (theCreditScore ?c &: (fuzzy-match ?c "high"))
=>
    
    (assert(theRating (new nrc.fuzzy.FuzzyValue ?*rating* "high or very high"))))

(defrule r23 ;"high theEmployment & low theEmployment & high theCreditScore=> rating high or medium or low"
    (theEmployment ?e &: (fuzzy-match ?e "high"))
    (theIncome ?i &: (fuzzy-match ?i "low"))
    (theCreditScore ?c &: (fuzzy-match ?c "high"))
=>
    
    (assert(theRating (new nrc.fuzzy.FuzzyValue ?*rating* "high or medium or low"))))

(defrule r24 ;"high theEmployment & medium theIncome & high theCreditScore=> rating medium or high"
    (theEmployment ?e &: (fuzzy-match ?e "high"))
    (theIncome ?i &: (fuzzy-match ?i "medium"))
    (theCreditScore ?c &: (fuzzy-match ?c "high"))
=>
 
    (assert(theRating (new nrc.fuzzy.FuzzyValue ?*rating* "high or medium"))))

(defrule r25 ;"medium theEmployment & high theIncome & high theCreditScore=> rating medium or high"
    (theEmployment ?e &: (fuzzy-match ?e "medium"))
    (theIncome ?i &: (fuzzy-match ?i "high"))
    (theCreditScore ?c &: (fuzzy-match ?c "high"))
=>
    
    (assert(theRating (new nrc.fuzzy.FuzzyValue ?*rating* "medium or high"))))

(defrule r26 ;"medium theEmployment & medium theIncome & high theCreditScore=> rating medium or high"
    (theEmployment ?e &: (fuzzy-match ?e "medium"))
    (theIncome ?i &: (fuzzy-match ?i "medium"))
    (theCreditScore ?c &: (fuzzy-match ?c "high"))
=>
   
    (assert(theRating (new nrc.fuzzy.FuzzyValue ?*rating* " medium or high "))))

(defrule r27 ;"medium theEmployment & low theIncome & high theCreditScore=> rating medium or low or high"
    (theEmployment ?e &: (fuzzy-match ?e "medium"))
    (theIncome ?i &: (fuzzy-match ?i "low"))
    (theCreditScore ?c &: (fuzzy-match ?c "high"))
=>
    (assert(theRating (new nrc.fuzzy.FuzzyValue ?*rating* "medium or low or high"))))

;Defuzzification

(defrule defuzzification
    (declare (salience -1))
    ?f <- (theRating ?z)
=>
    (str-cat "rating: " (?z momentDefuzzify))
	(bind ?calculated-rating (integer (?z momentDefuzzify)))
    (printout t "rating": ?calculated-rating crlf)
    (if (eq ?calculated-rating 5) then
    (printout t "The candidate has a low rating and loan will not be approved !" crlf)
    elif(eq ?calculated-rating 6) then
    (printout t "The candidate has a low rating and loan will not be approved !" crlf)    
    elif(eq ?calculated-rating 7) then
    (printout t "The candidate has a average rating and may or may not be approved for the loan!" crlf)
    elif(eq ?calculated-rating 8) then
    (printout t "The candidate has a average rating and may or may not be approved for the loan!" crlf)
    elif(eq ?calculated-rating 9) then
    (printout t "The candidate has a excellent rating and loan will be approved!" crlf)
    elif(eq ?calculated-rating 10) then
    (printout t "The candidate has a excellent rating and loan will be approved!" crlf)
    else
    (printout t "The candidate has a very low rating and is not suitable for the loan!" crlf))  
    
    (halt))



;function to run the application

(deffunction run-application ()
(reset)
(run))

;Run the above function in a loop to get back the prompt every time we have to enter the values for another candidate or re-run the program

(while TRUE
(run-application))
                               
                                
                                
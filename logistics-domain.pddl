(define (domain logistics)
  (:requirements :typing :durative-actions :fluents :numeric-fluents :duration-inequalities :continuous-effects)
  (:types 
  	 x - object
    )
  
  (:predicates 	
		(boolean)
        (shouldBeTrue)
 )
 (:functions
       (value) - number
 )
 
 (:durative-action test
    :parameters ()
    :duration (= ?duration 1)
    :condition (and 
    (over all (>= (value) 4))
    )
    :effect (and
      (at start (shouldBeTrue))  
      (decrease (value) (* #t 1))
      
    )
 
 )
  (:durative-action test2
    :parameters ()
    :duration (= ?duration 5)
    :condition (and 
    (at start (boolean))
    )
    :effect (and
      (at start (not (boolean)))
      (at end (boolean))
      
    )
 
 )
 
 
		
  
)

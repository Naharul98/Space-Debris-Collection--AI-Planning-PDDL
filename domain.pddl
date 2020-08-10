(define (domain debris-collection)
  (:requirements :typing :durative-actions :fluents :numeric-fluents :duration-inequalities)
  
(:types 	
    transportable - object
    rocket debris - transportable
    
    truck - object
    
    location - object                 
    place point - location    
    service-dock debris-bin refuel-station launch-pad landing-pad refuel-station - place
    launch-point landing-point space-point - point    
)

(:predicates 
    (at ?thisTransportable - transportable ?thisLocation - location)
    (on ?thisTransportable - transportable ?thisTruck - truck)
    (connected ?location1 ?location2 - location)
    
    (rocket-can-change-orbit ?thisRocket - rocket)
    (rocket-not-in-tracking-mode ?thisRocket - rocket)
    (rocket-tracking-debris ?thisRocket - rocket ?thisDebris - debris)
    (rocket-not-tracking-debris ?thisRocket - rocket ?thisDebris - debris)
    (rocket-not-examining-debris ?thisRocket - rocket)
    (rocket-not-collecting-debris ?thisRocket - rocket)
    (rocket-not-depositing-debris ?thisRocket - rocket)
    (rocket-not-refueling ?thisRocket - rocket)
    (rocket-solar-cells-opened ?thisRocket - rocket)
    (rocket-solar-cells-closed ?thisRocket - rocket)
    (rocket-absorbing-solar-energy ?thisRocket - rocket)
        
    (truck-at ?thisTruck - truck ?thisPlace - place)
    (truck-not-carrying-rocket ?thisTruck - truck)
    (truck-not-carrying-debris ?thisTruck - truck)    
    (truck-on-road ?thisTruck - truck ?start ?end - place)
    (truck-not-driving ?thisTruck - truck)
    (truck-not-picking-up-load ?thisTruck - truck)
    (truck-not-dropping-load ?thisTruck - truck)
    
    (debris-on-rocket ?thisDebris - debris ?thisRocket - rocket)
    (debris-collectable-by-rocket ?thisDebris - debris ?thisRocket - rocket)
    (debris-not-collected ?thisDebris - debris)
    
    (points-on-lateral-plane ?point1 ?point2 - point)
    (above ?point1 ?point2 - point)
    (below ?point1 ?point2 - point)
    (path-free-between ?point1 ?point2 - point)
    (point-not-occupied ?thisPoint - point)
    
    (launch-pad-not-in-use ?thisLaunchPad - launch-pad)
    (landing-pad-not-in-use ?thisLandingPad - landing-pad)
    
    (road-free-to-enter ?start ?end - place)    
    
    (debris-held ?thisDebris - debris)
    
)

(:functions 
    (distance-between ?location1 ?location2 - location) - number
    (time-between ?location1 ?location2 - location) - number
    (energy-required-between ?location1 ?location2 - location) - number
    
    (rocket-energy-consumption-rate ?thisRocket - rocket) - number
    (rocket-current-energy-level ?thisRocket - rocket) - number
    (rocket-maximum-energy-level ?thisRocket - rocket) - number
    (rocket-mass ?thisRocket - rocket) - number
    (rocket-current-holding-mass ?thisRocket - rocket) - number
    (rocket-maximum-holding-mass ?thisRocket - rocket) - number
    
    (debris-mass ?thisDebris - debris)

    (truck-speed ?thisTruck - truck) - number
    (truck-rocket-current-capacity ?thisTruck - truck) - number
    (truck-rocket-maximum-capacity ?thisTruck - truck) - number
    (truck-debris-current-capacity ?thisTruck - truck) - number
    (truck-debris-maximum-capacity ?thisTruck - truck) - number    
    
    (road-traffic-level ?place1 ?place2 - place) - number
    
    (refuel-station-current-capacity ?thisRefuelStation - refuel-station) - number
    (refuel-station-maximum-capacity ?thisRefuelStation - refuel-station) - number
    (refuel-station-refuel-rate ?thisRefuelStation - refuel-station) - number
    
     (solar-power-output) - number
     (total-energy) - number
)

(:durative-action take-off
    :parameters (?thisRocket - rocket ?thisLaunchPad - launch-pad ?thisLaunchPoint - launch-point)
    :duration (= ?duration (time-between ?thisLaunchPad ?thisLaunchPoint))
    :condition (and
        (at start (at ?thisRocket ?thisLaunchPad))
        (at start (point-not-occupied ?thisLaunchPoint))
          
        (at start (>= (rocket-current-energy-level ?thisRocket) 
        (* (energy-required-between ?thisLaunchPad ?thisLaunchPoint) (+ (rocket-mass ?thisRocket) (rocket-current-holding-mass ?thisRocket)))
        ))
        (at start (<= (rocket-current-holding-mass ?thisRocket) 0))
        
        (at start (rocket-solar-cells-closed ?thisRocket))
        (over all (rocket-solar-cells-closed ?thisRocket))
        
        (at start (launch-pad-not-in-use ?thisLaunchPad))
    )
    :effect (and
        (at start (not(at ?thisRocket ?thisLaunchPad)))
        (at start (not (point-not-occupied ?thisLaunchPoint)))               
        (at end (at ?thisRocket ?thisLaunchPoint))        
        
        (at start (decrease (rocket-current-energy-level ?thisRocket)
        (* (energy-required-between ?thisLaunchPad ?thisLaunchPoint) (+ (rocket-mass ?thisRocket) (rocket-current-holding-mass ?thisRocket)))
        ))
        
        (at start (not (launch-pad-not-in-use ?thisLaunchPad)))
        (at end (launch-pad-not-in-use ?thisLaunchPad))
    )
)

(:durative-action land
    :parameters (?thisRocket - rocket ?thisLandingPoint - landing-point ?thisLandingPad - landing-pad)
    :duration (= ?duration (time-between ?thisLandingPoint ?thisLandingPad))
    :condition (and
        (at start (at ?thisRocket ?thisLandingPoint))
        (at start (>= (rocket-current-energy-level ?thisRocket) 
        (* (energy-required-between ?thisLandingPoint ?thisLandingPad) (+ (rocket-mass ?thisRocket) (rocket-current-holding-mass ?thisRocket)))
        ))
        
        (at start (rocket-solar-cells-closed ?thisRocket))
        (over all (rocket-solar-cells-closed ?thisRocket))
        
        (at start (landing-pad-not-in-use ?thisLandingPad))
    )
    :effect (and
        (at start (not(at ?thisRocket ?thisLandingPoint)))
        (at start (point-not-occupied ?thisLandingPoint))
        (at end (at ?thisRocket ?thisLandingPad))
        
        (at start (decrease (rocket-current-energy-level ?thisRocket)
        (* (energy-required-between ?thisLandingPoint ?thisLandingPad) (+ (rocket-mass ?thisRocket) (rocket-current-holding-mass ?thisRocket)))
        ))
        
        (at start (not(landing-pad-not-in-use ?thisLandingPad)))
        (at end (landing-pad-not-in-use ?thisLandingPad))    
    )
)

(:durative-action start-orbit
    :parameters (?thisRocket - rocket ?thisLaunchPoint - launch-point ?thisSpacePoint - space-point)
    :duration (= ?duration (time-between ?thisLaunchPoint ?thisSpacePoint))
    :condition (and
       (at start (at ?thisRocket ?thisLaunchPoint))
       (at start (point-not-occupied ?thisSpacePoint))
       (at start (rocket-can-change-orbit ?thisRocket))
       (over all (rocket-can-change-orbit ?thisRocket))
       (over all (below ?thisLaunchPoint ?thisSpacePoint)) 
       
       (at start (>= (rocket-current-energy-level ?thisRocket) 
        (* (energy-required-between ?thisLaunchPoint ?thisSpacePoint) (+ (rocket-mass ?thisRocket) (rocket-current-holding-mass ?thisRocket)))
        ))
        
        (at start (rocket-solar-cells-closed ?thisRocket))
        (over all (rocket-solar-cells-closed ?thisRocket))
        
        (at start (path-free-between ?thisLaunchPoint ?thisSpacePoint))
    )
    :effect (and
        
        (at start (not (at ?thisRocket ?thisLaunchPoint)))
        (at start (not (point-not-occupied ?thisSpacePoint)))
        (at start (point-not-occupied ?thisLaunchPoint))
        
        (at end (at ?thisRocket ?thisSpacePoint))
        
        (at start (decrease (rocket-current-energy-level ?thisRocket)
        (* (energy-required-between ?thisLaunchPoint ?thisSpacePoint) (+ (rocket-mass ?thisRocket) (rocket-current-holding-mass ?thisRocket)))
        ))
        
        (at start (not (path-free-between ?thisLaunchPoint ?thisSpacePoint)))
        (at end (path-free-between ?thisLaunchPoint ?thisSpacePoint))
    )
)

(:durative-action end-orbit
    :parameters (?thisRocket - rocket ?thisSpacePoint - space-point ?thisLandingPoint - landing-point)
    :duration (= ?duration (time-between ?thisSpacePoint ?thisLandingPoint))
    :condition (and
       (at start (at ?thisRocket ?thisSpacePoint))
       (at start (point-not-occupied ?thisLandingPoint))
       (at start (rocket-can-change-orbit ?thisRocket))
       (over all (rocket-can-change-orbit ?thisRocket))
       (over all (above ?thisSpacePoint ?thisLandingPoint))  
              
       (at start (>= (rocket-current-energy-level ?thisRocket) 
        (* (energy-required-between ?thisSpacePoint ?thisLandingPoint) (+ (rocket-mass ?thisRocket) (rocket-current-holding-mass ?thisRocket)))
       ))
       
       (at start (rocket-solar-cells-closed ?thisRocket))
        (over all (rocket-solar-cells-closed ?thisRocket))
       
       (at start (path-free-between ?thisSpacePoint ?thisLandingPoint))
    )
    :effect (and
        (at start (not (at ?thisRocket ?thisSpacePoint)))
        (at start (not (point-not-occupied ?thisLandingPoint)))
        (at start (point-not-occupied ?thisSpacePoint))
        (at end (at ?thisRocket ?thisLandingPoint))
        
        (at start (decrease (rocket-current-energy-level ?thisRocket) 
        (* (energy-required-between ?thisSpacePoint ?thisLandingPoint) (+ (rocket-mass ?thisRocket) (rocket-current-holding-mass ?thisRocket)))
        ))
        
        (at start (not(path-free-between ?thisSpacePoint ?thisLandingPoint)))
        (at end (path-free-between ?thisSpacePoint ?thisLandingPoint))
    )
)

(:durative-action open-solar-cells  
    :parameters (?thisRocket - rocket)
    :duration (= ?duration 0.5)
    :condition (and 
        (at start (rocket-solar-cells-closed ?thisRocket))
        (at start (rocket-not-in-tracking-mode ?thisRocket))
    )
    :effect (and
        (at start (rocket-absorbing-solar-energy ?thisRocket))
    
        (at start (not (rocket-solar-cells-closed ?thisRocket)))
        (at end (rocket-solar-cells-opened ?thisRocket))
        
        (at start (not (rocket-can-change-orbit ?thisRocket)))
    )
)

(:durative-action absorb-solar-energy
    :parameters (?thisRocket - rocket)
    :duration (and (>= ?duration 0)
    (<= ?duration (/ (- (rocket-maximum-energy-level ?thisRocket) (rocket-current-energy-level ?thisRocket)) (solar-power-output) )))
    :condition (and
        (at start (rocket-absorbing-solar-energy ?thisRocket))
        (over all (rocket-absorbing-solar-energy ?thisRocket))
        (at start (rocket-solar-cells-opened ?thisRocket))
        (over all (rocket-solar-cells-opened ?thisRocket))
        (at start (rocket-not-in-tracking-mode ?thisRocket))
        (over all (rocket-not-in-tracking-mode ?thisRocket))
    )
    :effect (and
        (at end (increase (rocket-current-energy-level ?thisRocket) (* ?duration (solar-power-output))))
    
        (at end (not (rocket-absorbing-solar-energy ?thisRocket)))
    )
)

(:durative-action close-solar-cells
    :parameters (?thisRocket - rocket)
    :duration (= ?duration 0.5)
    :condition (and
        (at start (rocket-solar-cells-opened ?thisRocket))
        (at start (rocket-not-in-tracking-mode ?thisRocket))
    )
    :effect (and
        (at start (not (rocket-absorbing-solar-energy ?thisRocket)))
        
        (at start (not(rocket-solar-cells-opened ?thisRocket)))
        (at end (rocket-solar-cells-closed ?thisRocket))
        
        (at end (rocket-can-change-orbit ?thisRocket))    
    )
)

(:durative-action move-vertical-up
    :parameters (?thisRocket - rocket ?start ?end - point)
    :duration (= ?duration (time-between ?start ?end))
    :condition (and
        (at start (at ?thisRocket ?start))
        (at start (path-free-between ?start ?end))
        (at start (path-free-between ?end ?start))
        (at start (point-not-occupied ?end))        
        (at start (rocket-can-change-orbit ?thisRocket))
        (over all (rocket-can-change-orbit ?thisRocket))
        (over all (below ?start ?end))
        
        (at start (>= (rocket-current-energy-level ?thisRocket) 
        (* (energy-required-between ?start ?end) (+ (rocket-mass ?thisRocket) (rocket-current-holding-mass ?thisRocket)))
        ))
    )
    :effect (and
        (at start (not(at ?thisRocket ?start)))
        (at start (not(path-free-between ?start ?end)))
        (at start (point-not-occupied ?start))
        (at start(not (point-not-occupied ?end)))
       
        (at end (at ?thisRocket ?end))
        (at end (path-free-between ?start ?end))
        
        (at start (decrease (rocket-current-energy-level ?thisRocket) 
        (* (energy-required-between ?start ?end) (+ (rocket-mass ?thisRocket) (rocket-current-holding-mass ?thisRocket)))
        ))

    )
)

(:durative-action move-vertical-down
    :parameters (?thisRocket - rocket ?start ?end - point)
    :duration (= ?duration (time-between ?start ?end))
    :condition (and
        (at start (at ?thisRocket ?start))
        (at start (path-free-between ?start ?end))
        (at start (path-free-between ?end ?start))
        (at start (point-not-occupied ?end))
        (at start (rocket-can-change-orbit ?thisRocket))
        (over all (rocket-can-change-orbit ?thisRocket))
        (over all (above ?start ?end))
        
        (at start (>= (rocket-current-energy-level ?thisRocket) 
        (* (energy-required-between ?start ?end) (+ (rocket-mass ?thisRocket) (rocket-current-holding-mass ?thisRocket)))
        ))

    )
    :effect (and
        (at start (not(at ?thisRocket ?start)))
        (at start (not(path-free-between ?start ?end)))
        (at start (point-not-occupied ?start))
        (at start(not (point-not-occupied ?end)))
        
        (at end (at ?thisRocket ?end))
        (at end (path-free-between ?start ?end))
        
        (at start (decrease (rocket-current-energy-level ?thisRocket) 
        (* (energy-required-between ?start ?end) (+ (rocket-mass ?thisRocket) (rocket-current-holding-mass ?thisRocket)))
        ))
    )
)

(:durative-action move-lateral
    :parameters (?thisRocket - rocket ?start ?end - point)
    :duration (= ?duration (time-between ?start ?end))
    :condition (and
        (at start (at ?thisRocket ?start))
        (at start (path-free-between ?start ?end))
        (at start (path-free-between ?end ?start))
        (at start (point-not-occupied ?end))
        (at start (rocket-can-change-orbit ?thisRocket))
        (over all (rocket-can-change-orbit ?thisRocket))
        (over all (points-on-lateral-plane ?start ?end))
        
        (at start (>= (rocket-current-energy-level ?thisRocket) 
        (* (energy-required-between ?start ?end) (+ (rocket-mass ?thisRocket) (rocket-current-holding-mass ?thisRocket)))
        ))
    )
    :effect (and
        (at start (not(at ?thisRocket ?start)))
        (at start (not(path-free-between ?start ?end)))
        (at start (point-not-occupied ?start))
        (at start(not (point-not-occupied ?end)))
        
        (at end (at ?thisRocket ?end))
        (at end (path-free-between ?start ?end))
        
        (at start (decrease (rocket-current-energy-level ?thisRocket) 
        (* (energy-required-between ?start ?end) (+ (rocket-mass ?thisRocket) (rocket-current-holding-mass ?thisRocket)))
        ))
    )
)

(:durative-action start-tracking-debris
    :parameters (?thisRocket - rocket ?thisDebris - debris ?thisPoint - space-point)
    :duration (= ?duration 2.5)
    :condition (and 
        (at start (at ?thisRocket ?thisPoint))
        (at start (at ?thisDebris ?thisPoint))
        (over all (at ?thisRocket ?thisPoint))
        
        (at start (rocket-not-tracking-debris ?thisRocket ?thisDebris))
        
        (at start (rocket-not-in-tracking-mode ?thisRocket))
    )
    :effect (and
        (at start (rocket-tracking-debris ?thisRocket ?thisDebris))
        (at start (not (rocket-not-tracking-debris ?thisRocket ?thisDebris)))   
        
        (at start (not(rocket-not-in-tracking-mode ?thisRocket)))
        
        (at start (not (rocket-can-change-orbit ?thisRocket)))
    )
)

(:durative-action examine-debris
    :parameters (?thisRocket - rocket ?thisDebris - debris)
    :duration (= ?duration 3)
    :condition (and 
        (at start (rocket-tracking-debris ?thisRocket ?thisDebris))
        (over all (rocket-tracking-debris ?thisRocket ?thisDebris))
        
        (at start (<= (+ (rocket-current-holding-mass ?thisRocket) (debris-mass ?thisDebris)) (rocket-maximum-holding-mass ?thisRocket)))
        (at start (>= (rocket-current-energy-level ?thisRocket) (* 3 (rocket-energy-consumption-rate ?thisRocket))))
        
        (at start (rocket-not-examining-debris ?thisRocket))
    )
    :effect (and
        (at end (debris-collectable-by-rocket ?thisDebris ?thisRocket)  ) 
        
        (at start (decrease (rocket-current-energy-level ?thisRocket)(* 3 (rocket-energy-consumption-rate ?thisRocket))))
        
        (at start (not(rocket-not-examining-debris ?thisRocket)))
        (at end (rocket-not-examining-debris ?thisRocket))
    )
)

(:durative-action collect-debris
    :parameters (?thisRocket - rocket ?thisDebris - debris ?thisSpacePoint - space-point)
    :duration (= ?duration (* 0.02 (debris-mass ?thisDebris)))
    :condition (and  
        (at start (at ?thisRocket ?thisSpacePoint))
        (at start (at ?thisDebris ?thisSpacePoint))
        
        (at start (rocket-tracking-debris ?thisRocket ?thisDebris))
        (over all (rocket-tracking-debris ?thisRocket ?thisDebris))
        
        (at start (debris-collectable-by-rocket ?thisDebris ?thisRocket))
        (at start (debris-not-collected ?thisDebris))
        (over all (debris-collectable-by-rocket ?thisDebris ?thisRocket))
        
        (at start (>= (rocket-current-energy-level ?thisRocket)
        (* (* 0.02 (debris-mass ?thisDebris)) (rocket-energy-consumption-rate ?thisRocket))   
        ))
        
        (at start (rocket-not-collecting-debris ?thisRocket))
    )
    :effect (and
        (at start (not (debris-not-collected ?thisDebris)))
        (at start (not (at ?thisDebris ?thisSpacePoint)))        
        (at end (debris-on-rocket ?thisDebris ?thisRocket))
        
        (at start (increase (rocket-current-holding-mass ?thisRocket) (debris-mass ?thisDebris)))
        (at start (decrease (rocket-current-energy-level ?thisRocket)
        (* (* 0.02 (debris-mass ?thisDebris)) (rocket-energy-consumption-rate ?thisRocket))      
        ))
        (at end (assign (rocket-energy-consumption-rate ?thisRocket) (* 1.1 (rocket-energy-consumption-rate ?thisRocket))))
        
        (at start (not(rocket-not-collecting-debris ?thisRocket)))
        (at end (rocket-not-collecting-debris ?thisRocket))
    )
)

(:durative-action stop-successful-track
    :parameters (?thisRocket - rocket ?thisDebris - debris)
    :duration (= ?duration 1)
    :condition (and
        (at start (rocket-tracking-debris ?thisRocket ?thisDebris))
        (at start (debris-on-rocket ?thisDebris ?thisRocket))
        (at start (rocket-not-examining-debris ?thisRocket))
        (at start (rocket-not-collecting-debris ?thisRocket))        
        (over all (rocket-not-examining-debris ?thisRocket))
        (over all (rocket-not-collecting-debris ?thisRocket))
        
        (at start (>= (rocket-current-energy-level ?thisRocket)
        (* 1 (rocket-energy-consumption-rate ?thisRocket))      
        ))
    )
    :effect (and       
        (at end (not (rocket-tracking-debris ?thisRocket ?thisDebris)))
        (at end (rocket-not-tracking-debris ?thisRocket ?thisDebris))
        (at end (rocket-not-in-tracking-mode ?thisRocket))
        (at end (rocket-can-change-orbit ?thisRocket))
        
        (at start (decrease (rocket-current-energy-level ?thisRocket)
        (* 1 (rocket-energy-consumption-rate ?thisRocket))      
        ))
    )
)

(:durative-action stop-unsuccessful-track
    :parameters (?thisRocket - rocket ?thisDebris - debris ?from - space-point)
    :duration (= ?duration 1)
    :condition (and
        (at start (rocket-tracking-debris ?thisRocket ?thisDebris))
        (at start (at ?thisDebris ?from))
        (at start (rocket-not-examining-debris ?thisRocket))
        (at start (rocket-not-collecting-debris ?thisRocket))
        (over all (rocket-not-examining-debris ?thisRocket))
        (over all (rocket-not-collecting-debris ?thisRocket))
        
        (at start (>= (rocket-current-energy-level ?thisRocket)
        (* 1 (rocket-energy-consumption-rate ?thisRocket))      
        ))
    )
    :effect (and
        (at start (not (debris-collectable-by-rocket ?thisDebris ?thisRocket)))
        
        (at end (not (rocket-tracking-debris ?thisRocket ?thisDebris)))
        (at end (rocket-not-tracking-debris ?thisRocket ?thisDebris))
        (at end (rocket-not-in-tracking-mode ?thisRocket))
        (at end (rocket-can-change-orbit ?thisRocket))
        
        (at start (decrease (rocket-current-energy-level ?thisRocket)(* 1 (rocket-energy-consumption-rate ?thisRocket))))
    )
)

(:durative-action rocket-deposit-debris
    :parameters (?thisRocket - rocket ?thisDebris - debris ?thisPlace - place)
    :duration (= ?duration (* 0.1 (debris-mass ?thisDebris)))
    :condition (and
        (at start (at ?thisRocket ?thisPlace))
        (at start (debris-on-rocket ?thisDebris ?thisRocket))
        (over all (at ?thisRocket ?thisPlace))
        
        (at start (rocket-not-depositing-debris ?thisRocket))
    )
    :effect (and
        (at start (not(debris-on-rocket ?thisDebris ?thisRocket )))
        (at end (at ?thisDebris ?thisPlace))    
        
        (at end (decrease (rocket-current-holding-mass ?thisRocket) (debris-mass ?thisDebris)))   
        (at end (assign (rocket-energy-consumption-rate ?thisRocket) (* 0.8 (rocket-energy-consumption-rate ?thisRocket))))
        
        (at start (not (rocket-not-depositing-debris ?thisRocket)))
        (at end (rocket-not-depositing-debris ?thisRocket))
    )
)

(:durative-action truck-start-driving
    :parameters (?thisTruck - truck ?start ?end - place)
    :duration (= ?duration 0.1)
    :condition (and 
        (at start (road-free-to-enter ?start ?end))
        (at start (truck-not-driving ?thisTruck))
        (at start (truck-at ?thisTruck ?start))
    )
    :effect (and 
        (at start (not (road-free-to-enter ?start ?end)))
        (at start (not (truck-not-driving ?thisTruck)))
        (at start (not (truck-at ?thisTruck ?start)))
        
        (at end (truck-on-road ?thisTruck ?start ?end))
        (at end (increase (road-traffic-level ?start ?end) 1))
        (at end (road-free-to-enter ?start ?end))    
    )
)

(:durative-action drive-truck-with-no-traffic
    :parameters (?thisTruck - truck ?start ?end - place)
    :duration (at start (= ?duration (/ (* (road-traffic-level ?start ?end) (distance-between ?start ?end)) (truck-speed ?thisTruck))))
    :condition (and
        (at start (<= (road-traffic-level ?start ?end) 1))
        (at start (truck-on-road ?thisTruck ?start ?end))
        (over all (connected ?start ?end))
        (over all (truck-on-road ?thisTruck ?start ?end))
    )
    :effect (and
        (at end (truck-at ?thisTruck ?end))
        (at end (decrease (road-traffic-level ?start ?end) 1))
        (at end (not (truck-on-road ?thisTruck ?start ?end)))        
        (at end (truck-not-driving ?thisTruck))
    )
)

(:durative-action drive-truck-with-traffic
    :parameters (?thisTruck - truck ?start ?end - place)
    :duration (at start (= ?duration (/ (* (road-traffic-level ?start ?end) (distance-between ?start ?end)) (truck-speed ?thisTruck))))
    :condition (and
        (at start (>= (road-traffic-level ?start ?end) 2))
        (at start (truck-on-road ?thisTruck ?start ?end))
        (over all (connected ?start ?end))
        (over all (truck-on-road ?thisTruck ?start ?end))
    )
    :effect (and
        (at end (truck-at ?thisTruck ?end))
        (at end (decrease (road-traffic-level ?start ?end) 1))
        (at end (not (truck-on-road ?thisTruck ?start ?end)))        
        (at end (truck-not-driving ?thisTruck))
    )
)

(:durative-action truck-pick-up-rocket
    :parameters (?thisTruck - truck ?thisRocket - rocket ?thisPlace - place)
    :duration (= ?duration (* 0.2 (rocket-mass ?thisRocket)))
    :condition (and
        (at start (at ?thisRocket ?thisPlace))
        (at start (truck-at ?thisTruck ?thisPlace))
        (over all (truck-at ?thisTruck ?thisPlace))
        
        (at start (truck-not-carrying-debris ?thisTruck))
        (at start (<= (+ (truck-rocket-current-capacity ?thisTruck) 1) (truck-rocket-maximum-capacity ?thisTruck)))
        
        (at start (truck-not-picking-up-load ?thisTruck))
    )
    :effect (and
        (at start (not (at ?thisRocket ?thisPlace)))
        (at end (on ?thisRocket ?thisTruck ))    
        
        (at start(not(truck-not-carrying-rocket ?thisTruck))) 
        (at start (increase (truck-rocket-current-capacity ?thisTruck) 1))
        
        (at start (not(truck-not-picking-up-load ?thisTruck)))
        (at end (truck-not-picking-up-load ?thisTruck))
    )
)

(:durative-action truck-drop-rocket
    :parameters (?thisTruck - truck ?thisRocket - rocket ?thisPlace - place)
    :duration (= ?duration (* 0.2 (rocket-mass ?thisRocket)))
    :condition (and
        (at start (on ?thisRocket ?thisTruck))
        (at start (truck-at ?thisTruck ?thisPlace))
        (over all (truck-at ?thisTruck ?thisPlace))
        
        (at start (>= (- (truck-rocket-current-capacity ?thisTruck) 1) 1))
        
        (at start (truck-not-dropping-load ?thisTruck))
    )
    :effect (and 
        (at start (not(on ?thisRocket ?thisTruck )))
        (at end (at ?thisRocket ?thisPlace))
        
        (at end (decrease (truck-rocket-current-capacity ?thisTruck) 1))
        
        (at start (not(truck-not-dropping-load ?thisTruck)))
        (at end (truck-not-dropping-load ?thisTruck))(at end (truck-not-picking-up-load ?thisTruck))
    )
) 

(:durative-action truck-drop-rocket-making-truck-empty
    :parameters (?thisTruck - truck ?thisRocket - rocket ?thisPlace - place)
    :duration (= ?duration (* 0.2 (rocket-mass ?thisRocket)))
    :condition (and
        (at start (on ?thisRocket ?thisTruck))
        (at start (truck-at ?thisTruck ?thisPlace))
        (over all (truck-at ?thisTruck ?thisPlace))
        
        (at start (<= (- (truck-rocket-current-capacity ?thisTruck) 1) 0)) 
        
        (at start (truck-not-dropping-load ?thisTruck))
    )
    :effect (and 
        (at start (not(on ?thisRocket ?thisTruck )))
        (at end (at ?thisRocket ?thisPlace))
        
        (at start (truck-not-carrying-rocket ?thisTruck))
        (at end (decrease (truck-rocket-current-capacity ?thisTruck) 1))
        
        (at start (not(truck-not-dropping-load ?thisTruck)))
        (at end (truck-not-dropping-load ?thisTruck))
    )
)

(:durative-action truck-pick-up-debris
    :parameters (?thisTruck - truck ?thisDebris - debris ?thisPlace - place)
    :duration (= ?duration (* 0.05 (debris-mass ?thisDebris)))
    :condition (and
        (at start (at ?thisDebris ?thisPlace))
        (at start (truck-at ?thisTruck ?thisPlace))
        (over all (truck-at ?thisTruck ?thisPlace))
        
        (at start (truck-not-carrying-rocket ?thisTruck))  
        (at start (<= (+ (truck-debris-current-capacity ?thisTruck) 1) (truck-debris-maximum-capacity ?thisTruck)))
             
        (at start (truck-not-picking-up-load ?thisTruck)) 
    )
    :effect (and 
        (at start (not (at ?thisDebris ?thisPlace)))
        (at end (on ?thisDebris ?thisTruck))    
    
        (at start(not(truck-not-carrying-debris ?thisTruck))) 
        (at start (increase (truck-debris-current-capacity ?thisTruck) 1))        
        
        (at start (not(truck-not-picking-up-load ?thisTruck)))
        (at end (truck-not-picking-up-load ?thisTruck))
    )
)

(:durative-action truck-drop-debris
    :parameters (?thisTruck - truck ?thisDebris - debris ?thisPlace - place)
    :duration (= ?duration (* 0.05 (debris-mass ?thisDebris)))
    :condition (and
        (at start (on ?thisDebris ?thisTruck))
        (at start (truck-at ?thisTruck ?thisPlace))
        (over all (truck-at ?thisTruck ?thisPlace))
        
        (at start (>= (- (truck-debris-current-capacity ?thisTruck) 1) 1) )        
        
        (at start (truck-not-dropping-load ?thisTruck))
    )
    :effect (and 
        (at start (not(on ?thisDebris ?thisTruck )))
        (at end (at ?thisDebris ?thisPlace))
        
        (at end (decrease (truck-debris-current-capacity ?thisTruck) 1))
        
        (at start (not(truck-not-dropping-load ?thisTruck)))
        (at end (truck-not-dropping-load ?thisTruck))
    )
)

(:durative-action truck-drop-debris-making-truck-empty
    :parameters (?thisTruck - truck ?thisDebris - debris ?thisPlace - place)
    :duration (= ?duration (* 0.05 (debris-mass ?thisDebris)))
    :condition (and
        (at start (on ?thisDebris ?thisTruck))
        (at start (truck-at ?thisTruck ?thisPlace))
        (over all (truck-at ?thisTruck ?thisPlace))
        
        (at start (<= (- (truck-debris-current-capacity ?thisTruck) 1) 0) )
        
        (at start (truck-not-dropping-load ?thisTruck))
    )
    :effect (and 
        (at start (not(on ?thisDebris ?thisTruck )))
        (at end (at ?thisDebris ?thisPlace))
        
        (at start (truck-not-carrying-debris ?thisTruck))
        (at end (decrease (truck-debris-current-capacity ?thisTruck) 1))
        
        (at start (not(truck-not-dropping-load ?thisTruck)))
        (at end (truck-not-dropping-load ?thisTruck))
    )
)

(:durative-action refuel-rocket
    :parameters (?thisRocket - rocket ?thisRefuelStation - refuel-station)
    :duration (and (>= ? duration 0) 
    (<= ?duration (/ (- (rocket-maximum-energy-level ?thisRocket) (rocket-current-energy-level ?thisRocket)) (refuel-station-refuel-rate ?thisRefuelStation) )))
    :condition (and
        (at start (at ?thisRocket ?thisRefuelStation))
        (over all (at ?thisRocket ?thisRefuelStation))        
        (at start (<= (+ (refuel-station-current-capacity ?thisRefuelStation) 1) (refuel-station-maximum-capacity ?thisRefuelStation)))
        
        (at start (rocket-not-refueling ?thisRocket))
    )
    :effect (and     
        (at start (increase (refuel-station-current-capacity ?thisRefuelStation) 1))
        (at end (decrease (refuel-station-current-capacity ?thisRefuelStation) 1))
        (at end (increase (rocket-current-energy-level ?thisRocket) (* ?duration (refuel-station-refuel-rate ?thisRefuelStation))))
        
        (at end (increase (total-energy) (* ?duration (refuel-station-refuel-rate ?thisRefuelStation))))
        
        (at start (not (rocket-not-refueling ?thisRocket)))
        (at end (rocket-not-refueling ?thisRocket))
    )
)

)
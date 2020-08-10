(define (problem debris-collection-1)
(:domain debris-collection)

(:objects 
    rocket1 - rocket
    rocket2 - rocket
    
    debris1 - debris
    debris2 - debris
    debris3 - debris
    
    truck1 - truck
    truck2 - truck
    
    launchPoint1 - launch-point
    landingPoint1 - landing-point
    
    A1 - space-point
    A2 - space-point
    A3 - space-point
    B1 - space-point
    B2 - space-point
    B3 - space-point
    C1 - space-point
    C2 - space-point
    C3 - space-point
    
    launchPad1 - launch-pad
    landingPad1 - landing-pad
    serviceDock1 - service-dock
    debrisBin1 - debris-bin
    refuelStation1 - refuel-station
    
)

(:init
    (at rocket1 serviceDock1)
    (= (rocket-energy-consumption-rate rocket1) 0)  
    (= (rocket-current-energy-level rocket1) 100)    
    (= (rocket-maximum-energy-level rocket1) 100)
    (= (rocket-mass rocket1) 1)
    (= (rocket-current-holding-mass rocket1) 0)
    (= (rocket-maximum-holding-mass rocket1) 300)   
    (rocket-not-in-tracking-mode rocket1)
    (rocket-not-examining-debris rocket1)
    (rocket-not-collecting-debris rocket1)   
    (rocket-not-depositing-debris rocket1)
    (rocket-can-change-orbit rocket1)
    (rocket-not-refueling rocket1)
    (rocket-solar-cells-closed rocket1)
            
    (truck-at truck1 serviceDock1)
    (truck-not-carrying-rocket truck1)
    (truck-not-carrying-debris truck1)
    (truck-not-driving truck1)
    (truck-not-picking-up-load truck1)
    (truck-not-dropping-load truck1)
    (= (truck-speed truck1) 100)
    (= (truck-rocket-current-capacity truck1) 0)
    (= (truck-rocket-maximum-capacity truck1) 1)
    (= (truck-debris-current-capacity truck1) 0)
    (= (truck-debris-maximum-capacity truck1) 1)
    
    (at debris1 A1)
    (debris-not-collected debris1)
    (= (debris-mass debris1) 1)
    (rocket-not-tracking-debris rocket1 debris1)
    (rocket-not-tracking-debris rocket2 debris1)
    (at debris2 A2)
    (debris-not-collected debris2)
    (= (debris-mass debris2) 1)
    (rocket-not-tracking-debris rocket1 debris2)
    (rocket-not-tracking-debris rocket2 debris2)
    (at debris3 B2)
    (debris-not-collected debris3)
    (= (debris-mass debris3) 1)
    (rocket-not-tracking-debris rocket1 debris3)
    (rocket-not-tracking-debris rocket2 debris3)
        
    (points-on-lateral-plane A1 A2)
    (points-on-lateral-plane A2 A1)
    (points-on-lateral-plane B1 B2)
    (points-on-lateral-plane B2 B1)    
    (above A1 B1)
    (below B1 A1)
    (above A2 B2)
    (below B2 A2)
    (below launchPoint1 B1)
    (below launchPoint1 B2) 
    (above B1 landingPoint1)
    (above B2 landingPoint1)
    (path-free-between launchPoint1 B1) (= (time-between launchPoint1 B1) 1) (= (energy-required-between launchPoint1 B1) 1)
    (path-free-between launchPoint1 B2) (= (time-between launchPoint1 B2) 1) (= (energy-required-between launchPoint1 B2) 1)
    (path-free-between B1 landingPoint1) (= (time-between B1 landingPoint1) 1) (= (energy-required-between B1 landingPoint1) 1)
    (path-free-between B2 landingPoint1) (= (time-between B2 landingPoint1) 1) (= (energy-required-between B2 landingPoint1) 1)    
    (path-free-between A1 A2) (= (time-between A1 A2) 1) (= (energy-required-between A1 A2) 1)
    (path-free-between A2 A1) (= (time-between A2 A1) 1) (= (energy-required-between A2 A1) 1)
    (path-free-between B1 B2) (= (time-between B1 B2) 1) (= (energy-required-between B1 A2) 1)
    (path-free-between B2 B1) (= (time-between B2 B1) 1) (= (energy-required-between B2 B1) 1)
    (path-free-between A1 B1) (= (time-between A1 B1) 1) (= (energy-required-between A1 B1) 1)
    (path-free-between B1 A1) (= (time-between B1 A1) 1) (= (energy-required-between B1 A1) 1)
    (path-free-between A2 B2) (= (time-between A2 B2) 1) (= (energy-required-between A2 B2) 1)
    (path-free-between B2 A2) (= (time-between B2 A2) 1) (= (energy-required-between B2 A2) 1)    
    (= (time-between launchPad1 launchPoint1) 10) (= (energy-required-between launchPad1 launchPoint1) 1)
    (= (time-between landingPoint1 landingPad1) 10) (= (energy-required-between landingPoint1 landingPad1) 1)
    
    (point-not-occupied A1)
    (point-not-occupied A2)
    (point-not-occupied B1)
    (point-not-occupied B2)
    (point-not-occupied launchPoint1)
    (point-not-occupied landingPoint1)
            
    (= (refuel-station-current-capacity refuelStation1) 0)
    (= (refuel-station-maximum-capacity refuelStation1) 5)
    (= (refuel-station-refuel-rate refuelStation1) 100)
    
    (connected serviceDock1 refuelStation1)
    (= (distance-between serviceDock1 refuelStation1) 500)
    (= (road-traffic-level serviceDock1 refuelStation1) 0)
    (road-free-to-enter serviceDock1 refuelStation1)
    (connected refuelStation1 serviceDock1)
    (= (distance-between refuelStation1 serviceDock1 ) 500)
    (= (road-traffic-level refuelStation1 serviceDock1) 0)
    (road-free-to-enter refuelStation1 serviceDock1)
    
    (connected serviceDock1 launchPad1)
    (= (distance-between serviceDock1 launchPad1) 500)
    (= (road-traffic-level serviceDock1 launchPad1) 0)
    (road-free-to-enter serviceDock1 launchPad1)
    (connected launchPad1 serviceDock1)
    (= (distance-between launchPad1 serviceDock1) 500)   
    (= (road-traffic-level launchPad1 serviceDock1) 0)
    (road-free-to-enter launchPad1 serviceDock1)
    
    (connected serviceDock1 debrisBin1)
    (= (distance-between serviceDock1 debrisBin1) 500)
    (= (road-traffic-level serviceDock1 debrisBin1) 0)
    (road-free-to-enter serviceDock1 debrisBin1)
    (connected debrisBin1 serviceDock1)
    (= (distance-between debrisBin1 serviceDock1) 500)
    (= (road-traffic-level debrisBin1 serviceDock1) 0)
    (road-free-to-enter debrisBin1 serviceDock1)
    
    (connected serviceDock1 landingPad1)
    (= (distance-between serviceDock1 landingPad1) 500)
    (= (road-traffic-level serviceDock1 landingPad1) 0)
    (road-free-to-enter serviceDock1 landingPad1)
    (connected landingPad1 serviceDock1)
    (= (distance-between landingPad1 serviceDock1) 500)
    (= (road-traffic-level landingPad1 serviceDock1) 0)
    (road-free-to-enter landingPad1 serviceDock1)
    
    (launch-pad-not-in-use launchPad1)    
    (landing-pad-not-in-use landingPad1)
    
    (= (solar-power-output) 1)       
    (= (total-energy) 100)
)

(:goal
(and
   
   (at debris1 debrisBin1)
))
(:metric minimize total-time)
)
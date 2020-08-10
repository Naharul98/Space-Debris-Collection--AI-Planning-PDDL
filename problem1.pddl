(define (problem debris-collection-2)
(:domain debris-collection)

(:objects 
    rocket1 - rocket
    
    debris1 debris2 debris3 debris4 debris5 debris6 debris7 debris8 debris9 - debris
    
    truck1 - truck
    
    launchPoint1 - launch-point
    landingPoint1 - landing-point
    
    A1 A2 A3 A4 A5 - space-point
    B1 B2 B3 B4 - space-point  
    
    launchPad1 - launch-pad
    landingPad1 - landing-pad
    serviceDock1 - service-dock
    debrisBin1 - debris-bin
    refuelStation1 - refuel-station
    
)

(:init
    (at rocket1 refuelStation1)
    (= (rocket-energy-consumption-rate rocket1) 0)  
    (= (rocket-current-energy-level rocket1) 100)    
    (= (rocket-maximum-energy-level rocket1) 100)
    (= (rocket-mass rocket1) 1)
    (= (rocket-current-holding-mass rocket1) 0)
    (= (rocket-maximum-holding-mass rocket1) 100)   
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
    (= (truck-debris-maximum-capacity truck1) 25)
    
    (at debris1 A1)
    (debris-not-collected debris1)
    (= (debris-mass debris1) 10)
    (rocket-not-tracking-debris rocket1 debris1)
    (at debris2 A2)
    (debris-not-collected debris2)
    (= (debris-mass debris2) 10)
    (rocket-not-tracking-debris rocket1 debris2)
    (at debris3 A3)
    (debris-not-collected debris3)
    (= (debris-mass debris3) 10)
    (rocket-not-tracking-debris rocket1 debris3)
    (at debris4 A4)
    (debris-not-collected debris4)
    (= (debris-mass debris4) 10)
    (rocket-not-tracking-debris rocket1 debris4)
    (at debris5 B1)
    (debris-not-collected debris5)
    (= (debris-mass debris5) 10)
    (rocket-not-tracking-debris rocket1 debris5)
    (at debris6 B2)
    (debris-not-collected debris6)
    (= (debris-mass debris6) 10)
    (rocket-not-tracking-debris rocket1 debris6)
    (at debris7 B3)
    (debris-not-collected debris7)
    (= (debris-mass debris7) 10)
    (rocket-not-tracking-debris rocket1 debris7)
    (at debris8 B4)
    (debris-not-collected debris8)
    (= (debris-mass debris8) 10)
    (rocket-not-tracking-debris rocket1 debris8)
    (at debris9 A5)
    (debris-not-collected debris9)
    (= (debris-mass debris9) 10)
    (rocket-not-tracking-debris rocket1 debris9)
    
    (points-on-lateral-plane A1 A2)
    (points-on-lateral-plane A2 A1)
    (points-on-lateral-plane A2 A3)
    (points-on-lateral-plane A3 A2)
    (points-on-lateral-plane A3 A4)
    (points-on-lateral-plane A4 A3)
    (points-on-lateral-plane A4 A5)
    (points-on-lateral-plane A5 A4)
    
    (points-on-lateral-plane B1 B2)
    (points-on-lateral-plane B2 B1)
    (points-on-lateral-plane B2 B3)
    (points-on-lateral-plane B3 B2)
    (points-on-lateral-plane B3 B4)
    (points-on-lateral-plane B4 B3)
    
    (above B1 A1)
    (below A1 B1)
    (above B2 A2)
    (below A2 B2)
    (above B3 A3)
    (below A3 B3)
    (above B4 A4)
    (below A4 B4)

    (below launchPoint1 A2)
    (below launchPoint1 A3) 
    (above A2 landingPoint1)
    (above A3 landingPoint1)
    
    (path-free-between launchPoint1 A2) (= (time-between launchPoint1 A2) 1) (= (energy-required-between launchPoint1 A2) 1)
    (path-free-between launchPoint1 A3) (= (time-between launchPoint1 A3) 1) (= (energy-required-between launchPoint1 A3) 1)
    (path-free-between A2 landingPoint1) (= (time-between A2 landingPoint1) 1) (= (energy-required-between A2 landingPoint1) 1)
    (path-free-between A3 landingPoint1) (= (time-between A3 landingPoint1) 1) (= (energy-required-between A3 landingPoint1) 1)    
    
    (path-free-between A1 A2) (= (time-between A1 A2) 1) (= (energy-required-between A1 A2) 1)
    (path-free-between A2 A1) (= (time-between A2 A1) 1) (= (energy-required-between A2 A1) 1)
    (path-free-between A2 A3) (= (time-between A2 A3) 1) (= (energy-required-between A2 A3) 1)
    (path-free-between A3 A2) (= (time-between A3 A2) 1) (= (energy-required-between A3 A2) 1)
    (path-free-between A3 A4) (= (time-between A3 A4) 1) (= (energy-required-between A3 A4) 1)
    (path-free-between A4 A3) (= (time-between A4 A3) 1) (= (energy-required-between A4 A3) 1)
    (path-free-between A4 A5) (= (time-between A4 A5) 1) (= (energy-required-between A4 A5) 1)
    (path-free-between A5 A4) (= (time-between A5 A4) 1) (= (energy-required-between A5 A4) 1)
    
    (path-free-between B1 B2) (= (time-between B1 B2) 1) (= (energy-required-between B1 B2) 1)
    (path-free-between B2 B1) (= (time-between B2 B1) 1) (= (energy-required-between B2 B1) 1)
    (path-free-between B2 B3) (= (time-between B2 B3) 1) (= (energy-required-between B2 B3) 1)
    (path-free-between B3 B2) (= (time-between B3 B2) 1) (= (energy-required-between B3 B2) 1)
    (path-free-between B3 B4) (= (time-between B3 B4) 1) (= (energy-required-between B3 B4) 1)
    (path-free-between B4 B3) (= (time-between B4 B3) 1) (= (energy-required-between B4 B3) 1)
    
    (path-free-between A1 B1) (= (time-between A1 B1) 1) (= (energy-required-between A1 B1) 1)
    (path-free-between B1 A1) (= (time-between B1 A1) 1) (= (energy-required-between B1 A1) 1)
    (path-free-between A2 B2) (= (time-between A2 B2) 1) (= (energy-required-between A2 B2) 1)
    (path-free-between B2 A2) (= (time-between B2 A2) 1) (= (energy-required-between B2 A2) 1)
    (path-free-between A3 B3) (= (time-between A3 B3) 1) (= (energy-required-between A3 B3) 1)
    (path-free-between B3 A3) (= (time-between B3 A3) 1) (= (energy-required-between B3 A3) 1)
    (path-free-between A4 B4) (= (time-between A4 B4) 1) (= (energy-required-between A4 B4) 1)
    (path-free-between B4 A4) (= (time-between B4 A4) 1) (= (energy-required-between B4 A4) 1)
    
    (= (time-between launchPad1 launchPoint1) 10) (= (energy-required-between launchPad1 launchPoint1) 1)
    (= (time-between landingPoint1 landingPad1) 10) (= (energy-required-between landingPoint1 landingPad1) 1)
    
    (point-not-occupied A1)
    (point-not-occupied A2)
    (point-not-occupied A3)
    (point-not-occupied A4)
    (point-not-occupied A5)
    (point-not-occupied B1)
    (point-not-occupied B2)
    (point-not-occupied B3)
    (point-not-occupied B4)
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
   (at debris2 debrisBin1)
   (at debris3 debrisBin1)
   (at debris4 debrisBin1)
   (at debris5 debrisBin1)
   (at debris6 debrisBin1)
   (at debris7 debrisBin1)
   (at debris8 debrisBin1)
   (at debris9 debrisBin1)

))
;;(:metric minimize total-time)
;;(:metric minimize total-energy)
)

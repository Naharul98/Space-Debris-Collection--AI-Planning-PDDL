(define (problem debris-collection-2)
(:domain debris-collection)

(:objects 
    rocket1 rocket2 rocket3 - rocket

    debris1 debris2 debris3 debris4 debris5 - debris

    truck1 - truck
    
    launchPoint1 - launch-point
    landingPoint1 - landing-point

    C1 C2 C3 C4 C5 - space-point
        
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
    (= (rocket-maximum-holding-mass rocket1) 50)   
    (rocket-not-in-tracking-mode rocket1)
    (rocket-not-examining-debris rocket1)
    (rocket-not-collecting-debris rocket1)   
    (rocket-not-depositing-debris rocket1)
    (rocket-can-change-orbit rocket1)
    (rocket-not-refueling rocket1)
    (rocket-solar-cells-closed rocket1)

    (at rocket2 launchPad1)
    (= (rocket-energy-consumption-rate rocket2) 0)  
    (= (rocket-current-energy-level rocket2) 100)    
    (= (rocket-maximum-energy-level rocket2) 100)
    (= (rocket-mass rocket2) 2)
    (= (rocket-current-holding-mass rocket2) 0)
    (= (rocket-maximum-holding-mass rocket2) 50)   
    (rocket-not-in-tracking-mode rocket2)
    (rocket-not-examining-debris rocket2)
    (rocket-not-collecting-debris rocket2)   
    (rocket-not-depositing-debris rocket2)
    (rocket-can-change-orbit rocket2)
    (rocket-not-refueling rocket2)
    (rocket-solar-cells-closed rocket2)
    
    (at rocket3 landingPad1)
    (= (rocket-energy-consumption-rate rocket3) 0)  
    (= (rocket-current-energy-level rocket3) 100)    
    (= (rocket-maximum-energy-level rocket3) 100)
    (= (rocket-mass rocket3) 2)
    (= (rocket-current-holding-mass rocket3) 0)
    (= (rocket-maximum-holding-mass rocket3) 50)   
    (rocket-not-in-tracking-mode rocket3)
    (rocket-not-examining-debris rocket3)
    (rocket-not-collecting-debris rocket3)   
    (rocket-not-depositing-debris rocket3)
    (rocket-can-change-orbit rocket3)
    (rocket-not-refueling rocket3)
    (rocket-solar-cells-closed rocket3)
      
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

    (at debris1 C1)
    (debris-not-collected debris1)
    (= (debris-mass debris1) 10)
    (rocket-not-tracking-debris rocket1 debris1)
    (rocket-not-tracking-debris rocket2 debris1)
    (rocket-not-tracking-debris rocket3 debris1)

    (at debris2 C2)
    (debris-not-collected debris2)
    (= (debris-mass debris2) 10)
    (rocket-not-tracking-debris rocket1 debris2)
    (rocket-not-tracking-debris rocket2 debris2)
    (rocket-not-tracking-debris rocket3 debris2)

    (at debris3 C3)
    (debris-not-collected debris3)
    (= (debris-mass debris3) 10)
    (rocket-not-tracking-debris rocket1 debris3)
    (rocket-not-tracking-debris rocket2 debris3)
    (rocket-not-tracking-debris rocket3 debris3)
    
    (at debris4 C4)
    (debris-not-collected debris4)
    (= (debris-mass debris4) 10)
    (rocket-not-tracking-debris rocket1 debris4)
    (rocket-not-tracking-debris rocket2 debris4)
    (rocket-not-tracking-debris rocket3 debris4)

    (at debris5 C5)
    (debris-not-collected debris5)
    (= (debris-mass debris5) 10)
    (rocket-not-tracking-debris rocket1 debris5)
    (rocket-not-tracking-debris rocket2 debris5)
    (rocket-not-tracking-debris rocket3 debris5)

    (points-on-lateral-plane C1 C2)
    (points-on-lateral-plane C2 C1)
    (points-on-lateral-plane C2 C3)
    (points-on-lateral-plane C3 C2)
    (points-on-lateral-plane C3 C4)
    (points-on-lateral-plane C4 C3)
    (points-on-lateral-plane C4 C5)
    (points-on-lateral-plane C5 C4)
    (points-on-lateral-plane C1 C5)
    (points-on-lateral-plane C5 C1)   

    (below launchPoint1 C1)
    (below launchPoint1 C2)
    (below launchPoint1 C3)
    (below launchPoint1 C4)
    (below launchPoint1 C5)

    (above C1 landingPoint1)
    (above C2 landingPoint1)
    (above C3 landingPoint1)
    (above C4 landingPoint1)
    (above C5 landingPoint1)

    (path-free-between launchPoint1 C1) (= (time-between launchPoint1 C1) 1) (= (energy-required-between launchPoint1 C1) 1)
    (path-free-between C1 landingPoint1) (= (time-between C1 landingPoint1) 1) (= (energy-required-between C1 landingPoint1) 1)
    (path-free-between launchPoint1 C2) (= (time-between launchPoint1 C2) 1) (= (energy-required-between launchPoint1 C2) 1)
    (path-free-between C2 landingPoint1) (= (time-between C2 landingPoint1) 1) (= (energy-required-between C2 landingPoint1) 1)
    (path-free-between launchPoint1 C3) (= (time-between launchPoint1 C3) 1) (= (energy-required-between launchPoint1 C3) 1)
    (path-free-between C3 landingPoint1) (= (time-between C3 landingPoint1) 1) (= (energy-required-between C3 landingPoint1) 1)
    (path-free-between launchPoint1 C4) (= (time-between launchPoint1 C4) 1) (= (energy-required-between launchPoint1 C4) 1)
    (path-free-between C4 landingPoint1) (= (time-between C4 landingPoint1) 1) (= (energy-required-between C4 landingPoint1) 1)
    (path-free-between launchPoint1 C5) (= (time-between launchPoint1 C5) 1) (= (energy-required-between launchPoint1 C5) 1)
    (path-free-between C5 landingPoint1) (= (time-between C5 landingPoint1) 1) (= (energy-required-between C5 landingPoint1) 1)

    (path-free-between C1 C2) (= (time-between C1 C2) 1) (= (energy-required-between C1 C2) 1)
    (path-free-between C2 C1) (= (time-between C2 C1) 1) (= (energy-required-between C2 C1) 1)

    (path-free-between C2 C3) (= (time-between C2 C3) 1) (= (energy-required-between C2 C3) 1)
    (path-free-between C3 C2) (= (time-between C3 C2) 1) (= (energy-required-between C3 C2) 1)

    (path-free-between C3 C4) (= (time-between C3 C4) 1) (= (energy-required-between C3 C4) 1)
    (path-free-between C4 C3) (= (time-between C4 C3) 1) (= (energy-required-between C4 C3) 1)

    (path-free-between C4 C5) (= (time-between C4 C5) 1) (= (energy-required-between C4 C5) 1)
    (path-free-between C5 C4) (= (time-between C5 C4) 1) (= (energy-required-between C5 C4) 1)    

    (path-free-between C1 C5) (= (time-between C1 C5) 1) (= (energy-required-between C1 C5) 1)
    (path-free-between C5 C1) (= (time-between C5 C1) 1) (= (energy-required-between C5 C1) 1) 
  
    (= (time-between launchPad1 launchPoint1) 10) (= (energy-required-between launchPad1 launchPoint1) 1)
    (= (time-between landingPoint1 landingPad1) 10) (= (energy-required-between landingPoint1 landingPad1) 1)

    (point-not-occupied C1)
    (point-not-occupied C2)
    (point-not-occupied C3)
    (point-not-occupied C4)
    (point-not-occupied C5)
    (point-not-occupied launchPoint1)
    (point-not-occupied landingPoint1)
            
    (= (refuel-station-current-capacity refuelStation1) 0)
    (= (refuel-station-maximum-capacity refuelStation1) 10)
    (= (refuel-station-refuel-rate refuelStation1) 100)
    
    (connected serviceDock1 refuelStation1)
    (= (distance-between serviceDock1 refuelStation1) 500)
    (= (road-traffic-level serviceDock1 refuelStation1) 0)
    (road-free-to-enter serviceDock1 refuelStation1)
    (connected refuelStation1 serviceDock1)
    (= (distance-between refuelStation1 serviceDock1) 500)
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

))
(:metric minimize total-time)
)
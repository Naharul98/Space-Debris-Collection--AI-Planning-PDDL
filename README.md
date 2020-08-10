# Solving space debris collection using AI Planning
**Using artificial intelligence automated planning to efficiently execute space debris collection**


## AI Planning tool used:
This project uses an AI planning tool known as [OPTIC](https://nms.kcl.ac.uk/planning/index.html). A ready to use version is included in this project.

## Domain and Problem definition
The domain of the space debris collection is defined in the following file:
> domain.pddl

In order to test the planner, 3 different problems within the domain is defined. These are defined in the following files:
> problem1.pddl, problem2.pddl and problem3.pddl

# Running the AI planner:
```
cd <project directory path>
optic-clp.exe -N <domain file name> <problem file name>
```
Example:
```
cd C:\Optic

optic-clp.exe -N domain.pddl problem.pddl
optic-clp.exe -N domain.pddl problem2.pddl
```

## Domain Description:
### Model of Earth
The types of places in earth consist of service docks where rockets can be stored, landing and launch pads from which rockets can take off and land, debris bins where debris can be safely disposed of and refuel stations where rockets can replenish their energy supply.

The Earth is modelled as set of places which can be travelled to and from if there exists a set of roads that connects them. Roads can be traversed by truck, trucks can pick up and drop rockets and/or debris to and from different places.

##### Transportation of Spaceships and disposal of debris within earth and Launch from Earth.
Rockets can get to and from places on Earth being transported by trucks. These trucks have a maximum rocket and debris capacity and can carry up to this many rockets or debris at once. However, a truck cannot carry a rocket and debris simultaneously as the handling of rockets requires more care than debris therefore carrying both types of object at the same time is likely to lead to damages, hence the model prevents this from happening.

##### Lauch of spaceship from Earth
Rockets can go from places on Earth to points in space by taking off and starting to orbit. A rocket must first launch and reach a launch point in space then from there it can begin its orbit and enter the grid. Only a single rocket can launch at any given time from the same launch pad, therefore to make multiple rockets take off simultaneously multiple launch pads need to be instantiated and connected. The action of taking off and starting to orbit are seperated to increase the models utility. For instance, if multiple rockets were able to take off directly to points in space these points can become occupied very quickly.

Thus long queues can form where rockets are left waiting on the launch pad. Whereas, if rockets take off to a launch point then they can get into space more quickly and then it becomes the planners responsibility where in the space grid they should navigate to. Also, this implementation is more realistic as rocket launches are likely to follow a similar path initially and the energy required to go from Earth to space and then different points in space is likely to be vastly different, this is taken into account by the model.

##### Consideration of Traffic congestion during transportation within Earth
The model takes into consideration the effects of traffic, when there are multiple trucks travelling along the same road they are likely to drive slower thus increasing the travel time between two places. The model keeps a record of how many trucks are on any given road at any given time and increases the travel time for each truck proportionally to this, the greater the ammount of trucks on a road the greater the level of congestion.


#### Model of Space
The space is modelled by a 3D grid abstraction, consisting of vertices, which are modelled as points, and edges, which are modelled by paths. The changing of orbit of a rocket is modelled by travelling along a path in straight lines along the edges. the trajectory of a real rocket is likely to be curved, however this detail is abstracted from the model and instead the time taken to travel between points whether straight or curved is defined by the problem designer.





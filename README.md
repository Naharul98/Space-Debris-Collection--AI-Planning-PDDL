# Solving space debris collection using AI Planning
**Using artificial intelligence automated planning to efficiently execute and evaluate space debris collection**


## AI Planning tool used:
This project uses an AI planning tool known as [OPTIC](https://nms.kcl.ac.uk/planning/index.html). A ready to use version is included in this project.

## Domain and Problem definition:
The domain of the space debris collection is defined in the following file:
> domain.pddl

In order to test the planner, 3 different problems within the domain is defined. These are defined in the following files:
> problem1.pddl, problem2.pddl and problem3.pddl

## Running the AI planner:
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

## Domain Description (Defined within domain.pddl file):
### Model of Earth:
The types of places in earth consist of service docks where rockets can be stored, landing and launch pads from which rockets can take off and land, debris bins where debris can be safely disposed of and refuel stations where rockets can replenish their energy supply.

The Earth is modelled as set of places which can be travelled to and from if there exists a set of roads that connects them. Roads can be traversed by truck, trucks can pick up and drop rockets and/or debris to and from different places.

##### Transportation of Spaceships and disposal of debris within Earth:
Rockets can get to and from places on Earth being transported by trucks. These trucks have a maximum rocket and debris capacity and can carry up to this many rockets or debris at once. However, a truck cannot carry a rocket and debris simultaneously as the handling of rockets requires more care than debris therefore carrying both types of object at the same time is likely to lead to damages, hence the model prevents this from happening.

##### Lauch of spaceship from Earth:
Rockets can go from places on Earth to points in space by taking off and starting to orbit. A rocket must first launch and reach a launch point in space then from there it can begin its orbit and enter the grid. Only a single rocket can launch at any given time from the same launch pad, therefore to make multiple rockets take off simultaneously multiple launch pads need to be instantiated and connected. 

##### Consideration of Traffic congestion during transportation within Earth:
The model keeps a record of how many trucks (transporting rockets) are on any given road at any given time and increases the travel time for each truck proportionally to this, the greater the amount of trucks on a road the greater the level of congestion.

### Model of Space:
The space is modelled by a 3D grid abstraction, consisting of vertices, which are modelled as points, and edges, which are modelled by paths. The changing of orbit of a rocket is modelled by travelling along a path in straight lines along the edges. The trajectory of a real rocket is likely to be curved, however this detail is abstracted from the model and instead the time taken to travel between points whether straight or curved is defined by the problem designer.

##### Movement of Rocket in space:
For a rocket to increase its orbital radius, it can move upwards vertically for it to decrease its orbital radius it can travel downwards vertically. For the rocket to maintain its orbital radius but to shift directions it can move laterally. 

The model prevents collisions in space between rockets and between rockets and debris. Two rockets are not permitted to be at the same point at the same time, two rockets cannot travel along the same path in opposite directions and multiple rockets cannot travel along different paths towards the same point simultaneously. Furthermore, whenever a rocket comes into close proximity to a debris it must enter tracking mode where it follows the debris but cannot move else where to avoid the rocket and debris colliding.

#### Energy consumption of rocket within space:
As the rocket holds a larger number of debris, the mass of the rocket increases therefore the energy consumption rate of the rocket increases. This means the rocket can stay in space for a shorter ammount of time for a given ammount of fuel at a higher mass compared to a lower mass. The planner can then decide between picking up greater quanties of mass and staying in orbit for longer absorbing energy from the sun or, returning to Earth and depositing the debris quickly.

#### Using solar power within space to replenish rocket energy:
Whilst a rocket is in orbit it can open its solar cells and begin absorbing solar energy from the sun. However, a rocket cannot have its solar cells open whilst tracking a debris to avoid damaging the rocket.

### Model of space debris collection:
Debris collection is modelled by rockets picking up debris orbitting the earth and bringing them back. In order for a rocket to safely collect a debris, it must first be within close proximity to the debris in order for the rocket to begin tracking. Then the rocket must make an assessment of whether it can pick up the debris given its maximum holding capacity and fuel constraints. If the rocket makes a successful assessment then the rocket can pick the debris up and stop tracking the debris.The debris are then brought back to Earth to be disposed of. 

## Planner Evaluation (based on the problem files defined):
### Problem 1
The first problem definition was constructed with the purpose of benchmarking in mind. it consisted of a single truck, which could move between 5 location on earth. Subsequently, the number of debris pieces were increased proportionally to the number of space points, such that, number of space point is two more than number of debris. The results are summarized below:

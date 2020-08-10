# Solving space debris collection using AI Planning
**Using artificial intelligence automated planning to efficiently execute space debris collection**


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
Rockets can go from places on Earth to points in space by taking off and starting to orbit. A rocket must first launch and reach a launch point in space then from there it can begin its orbit and enter the grid. Only a single rocket can launch at any given time from the same launch pad, therefore to make multiple rockets take off simultaneously multiple launch pads need to be instantiated and connected. The action of taking off and starting to orbit are seperated to increase the models utility. For instance, if multiple rockets were able to take off directly to points in space these points can become occupied very quickly.

Thus long queues can form where rockets are left waiting on the launch pad. Whereas, if rockets take off to a launch point then they can get into space more quickly and then it becomes the planners responsibility where in the space grid they should navigate to. Also, this implementation is more realistic as rocket launches are likely to follow a similar path initially and the energy required to go from Earth to space and then different points in space is likely to be vastly different, this is taken into account by the model.

##### Consideration of Traffic congestion during transportation within Earth:
The model takes into consideration the effects of traffic, when there are multiple trucks travelling along the same road they are likely to drive slower thus increasing the travel time between two places. The model keeps a record of how many trucks are on any given road at any given time and increases the travel time for each truck proportionally to this, the greater the ammount of trucks on a road the greater the level of congestion.


### Model of Space:
The space is modelled by a 3D grid abstraction, consisting of vertices, which are modelled as points, and edges, which are modelled by paths. The changing of orbit of a rocket is modelled by travelling along a path in straight lines along the edges. the trajectory of a real rocket is likely to be curved, however this detail is abstracted from the model and instead the time taken to travel between points whether straight or curved is defined by the problem designer.

##### Movement of Rocket in space:
For a rocket to increase its orbital radius, it can move upwards vertically for it to decrease its orbital radius it can travel downwards vertically. For the rocket to maintain its orbital radius but to shift directions it can move laterally. These actions can be performed by the rocket to navigate the space grid, travelling with and against gravity are likely to have different energy requirements. Moreover, the time peroid of going to a higher orbit or lower orbit are likely to be different then just changing direction since the rocket follows a more curved path, thus the actions have been separated into different axis.

The model prevents collisions in space between rockets and between rockets and debris. Two rockets are not permitted to be at the same point at the same time, two rockets cannot travel along the same path in opposite directions and multiple rockets cannot travel along different paths towards the same point simultaneously. Furthermore, whenever a rocket comes into close proximity to a debris it must enter tracking mode where it follows the debris but cannot move else where to avoid the rocket and debris colliding.

#### Energy consumption of rocket within space:
The energy required to travel between points in space is calculated by the problem designer. Since the energy required for the rocket to travel between points varies proportional to the total mass of the rocket, and the rocket’s mass is likely to vary given the number of debris it picks up, the energy requirement calculations are expected to factor out mass of the rocket to give a more accurate energy constraint throughout, the energy requirement is then multiplied by total mass of the rocket in the model when the function is needed.

As the rocket holds a larger number of debris, the mass of the rocket increases therefore the energy consumption rate of the rocket increases. This means the rocket can stay in space for a shorter ammount of time for a given ammount of fuel at a higher mass compared to a lower mass. The planner can then decide between picking up greater quanties of mass and staying in orbit for longer absorbing energy from the sun or, returning to Earth and depositing the debris quickly.

#### Using solar power within space to replenish rocket energy:
Whilst a rocket is in orbit it can open its solar cells and begin absorbing solar energy from the sun. A rocket cannot have its solar cells open whilst tracking a debris to avoid damaging the rocket, altough this means the rocket cannot both move and absorb solar energy at the same time the effects would be negligble in reality since the eneregy expended in rocket thrusts exceeds that gained by the rocket from the sun.

### Modelling space debris collection:
Debris collection is modelled by rockets picking up debris orbitting the earth and bringing them back. In order for a rocket to safely collect a debris, it must first be within close proximity to the debris in order for the rocket to begin tracking. Then the rocket must make an assessment of whether it can pick up the debris given its maximum holding capacity and fuel constraints. If the rocket makes a successful assessment then the rocket can pick the debris up and stop tracking the debris.

The debris can be brought back to Earth to be disposed of. The actions of examining and collecting a debris must be performed whilst the rocket is tracking the debris and the debris can only be collected after an examination has been made. Successful tracks are defined as tracks where the rocket was able to pick the debris up and unsuccessful tracks are ones where the debris was not able to be picked up. This increases the flexibility of the planner as the rocket can come in to contact with a debris and even if it can pick it up it can choose not to incase there are better options, this optomises the model under time constraints as it may come in to contact with better options further in its orbit.

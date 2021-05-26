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
Consists of:
* Docks, Landing/Launch pad of rockets.
* Debris bin where debris is disposed off
* Rocket fueling station

##### Transportation of Spaceships and disposal of debris within Earth:
* Rockets have to be transported by trucks to the launch pads.
* Debris is taken from rockets to the disposal bin by trucks

##### Lauch of spaceship from Earth:
* A rocket must first launch and reach a launch point in space then from there it can begin its orbit and enter the grid
* Only a single rocket can launch at any given time from the same launch pad

### Model of Space:
* The space is modelled by a 3D grid abstraction, consisting of straight line vertices, which are modelled as points, and edges, which are modelled by paths.
* The time taken to travel between points whether straight or curved is defined by the problem designer.

The trajectory of a real rocket is likely to be curved, however this detail is abstracted from the model.

#### Energy consumption of rocket within space:
* As the rocket holds a larger number of debris, the mass of the rocket increases therefore the energy consumption rate of the rocket increases.
* The planner can then decide between picking up greater quanties of mass and staying in orbit for longer or returning to Earth and depositing the debris quickly.

#### Using solar power within space to replenish rocket energy:
* Whilst a rocket is in orbit it can open its solar cells and begin absorbing solar energy from the sun. 

## Planner Evaluation (based on the problem files defined):
### Problem 1
![Benchmark1](https://github.com/Naharul98/Space-Debris-Collection--AI-Planning-PDDL/blob/master/problem1_evaluation_chart.jpg?raw=true)

Whilst the planner found a solution very quickly in a small state space (4.9 seconds for a single piece of debris), for larger ones the time rose exponentially (167 seconds for 9 debris pieces). Finally, with over 10 pieces of debris the planner simply ran out of memory *(as OPTIC for Windows is a 32-bit application it is unable to use more than 4GB of memory).*

### Problem 2

![Benchmark2](https://github.com/Naharul98/Space-Debris-Collection--AI-Planning-PDDL/blob/master/problem2_evaluation_chart.jpg?raw=true)

For this problem the planner successfully split debris collection among the two rockets. There was, however, some time wasted when the truck moves back and forth between the service dock and landing pad. 

### Problem 3

![Benchmark2](https://github.com/Naharul98/Space-Debris-Collection--AI-Planning-PDDL/blob/master/problem3_evaluation_chart.jpg?raw=true)

The planner found a solution in a reasonable amount of time in a small state space, however, for larger ones with over 3 rockets the planner simply ran out of memory due to OPTIC’s limitation being a 32-bit application. 

## Conclusion
* Problem instances do not scale well with the OPTIC planner, primarily because of its 32 bit limitation with regards to memory usage.
* The plan output by the planner does not always find the most optimal solution, however, in those cases, they are reasonably close to optimal.



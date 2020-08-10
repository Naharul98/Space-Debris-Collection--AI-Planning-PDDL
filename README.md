# Solving space debris collection using AI Planning
**Using artificial intelligence automated planning to efficiently execute space debris collection**


#### AI Planning tool used:
This project uses an AI planning tool known as [OPTIC](https://nms.kcl.ac.uk/planning/index.html). A ready to use version is included in this project.

#### Domain and Problem definition
The domain of the space debris collection is defined in the following file:
> domain.pddl

In order to test the planner, 3 different problems within the domain is defined. These are defined in the following files:
> problem1.pddl, problem2.pddl and problem3.pddl

#### Running the AI planner:
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

#### Domain Description

**Domain within Earth**
The types of places within earth:*
* service docks where rockets can be stored. 
* landing and launch pads from which rockets can take off and land.
* debris bins where debris can be safely disposed of
* refuel stations where rockets can replenish their energy supply.
* The Earth is modelled as set of places which can be travelled to and from if there exists a set of roads that connects them.
* Roads can be traversed by truck, trucks can pick up and drop rockets and/or debris to and from different places.
* 
**Domain within Space**
* The space is modelled by a 3D grid abstraction, consisting of vertices, which are modelled as points, and edges, which are modelled by paths.


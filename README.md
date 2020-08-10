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


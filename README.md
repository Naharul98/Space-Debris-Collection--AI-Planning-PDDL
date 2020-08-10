# Solving space debris collection using AI Planning
**Using artificial intelligence automated planning to efficiently execute space debris collection**


### AI Planning tool used:
This project uses an AI planning tool known as [OPTIC](https://nms.kcl.ac.uk/planning/index.html). The ready to use binary is included in this project

### Running the AI planner:
```
cd <project directory path>
optic-clp.exe -N <domain file name> <problem file name>

```

Example:
```
cd C:\OpticForWindows

optic-clp.exe -N domain.pddl problem.pddl

optic-clp.exe -N domain.pddl problem2.pddl

```


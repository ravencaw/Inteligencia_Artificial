package aima.core.environment.Labyrinth;

import aima.core.search.framework.problem.GoalTest;

/**
 * @author Ravi Mohan
 * 
 */
public class LabyrinthGoalTest implements GoalTest {
	LabyrinthBoard goal = new LabyrinthBoard(0, 9);
                
        @Override
	public boolean isGoalState(Object state) {
		LabyrinthBoard board = (LabyrinthBoard) state;
		return board.equals(goal);
	}
}
package aima.core.environment.laberinto;

import aima.core.search.framework.problem.GoalTest;

/**
 * @author Ravi Mohan
 *
 */
public class LaberintoGoalTest implements GoalTest {

    LaberintoBoard goal = new LaberintoBoard(3, 3);
    //LaberintoBoard stop = new LaberintoBoard(2, 1);

//    public boolean isReachKState(Object state) {
//        LaberintoBoard board = (LaberintoBoard) state;
//        return board.equals(goal);
//    }
    @Override
    public boolean isGoalState(Object state) {
        LaberintoBoard board = (LaberintoBoard) state;
        return board.equals(goal) && board.isKPassed(2, 1);
    }
}

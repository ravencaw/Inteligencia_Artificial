package aima.core.environment.laberinto;

import aima.core.search.framework.problem.GoalTest;

/**
 * @author Ravi Mohan
 *
 */
public class LaberintoGoalWithKTest implements GoalTest {

    LaberintoBoard goal = new LaberintoBoard(3, 3);
    //LaberintoBoard stop = new LaberintoBoard(2, 1);

//    public boolean isReachKState(Object state) {
//        LaberintoBoard board = (LaberintoBoard) state;
//        return board.equals(goal);
//    }
    @Override
    public boolean isGoalState(Object state) {
        LaberintoBoard board = (LaberintoBoard) state;
        boolean res = false;
        
        if(board.isKPassed(2, 1)){
         
            if(board.equals(goal)){
                res = true;
            }
        }
        
        board.printPath();
        
        return res;
        //return board.equals(goal);
    }
}

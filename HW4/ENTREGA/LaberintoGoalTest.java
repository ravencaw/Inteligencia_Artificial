package aima.core.environment.laberinto;

import aima.core.search.framework.problem.GoalTest;

public class LaberintoGoalTest implements GoalTest {

    char[][] labState = new LaberintoBoard().readFile("laberinto.txt");
//    private static char labState[][] = {
//        {'S', ' ', ' ', '%'},
//        {' ', '%', ' ', '%'},
//        {'%', 'K', ' ', '%'},
//        {'%', ' ', ' ', 'G'}
//    };
    
    int[] goalCoor = findGoal(labState);

    LaberintoBoard goal = new LaberintoBoard(goalCoor[0], goalCoor[1], true);

    @Override
    public boolean isGoalState(Object state) {
        //System.out.println("loko");
        LaberintoBoard board = (LaberintoBoard) state;
       
        //board.printPath();
        
        return board.equals(goal);
    }

    public int[] findGoal(char[][] state) {

        int[] xy = new int[2];

        for (int i = 0; i < state.length; i++) {

            for (int j = 0; j < state[i].length; j++) {
                
                if (state[i][j] == 'G') {
                    xy[0] = i;
                    xy[1] = j;
                }
            }
        }
        return xy;
    }

}

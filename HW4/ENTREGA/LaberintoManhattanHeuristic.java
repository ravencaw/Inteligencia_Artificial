package aima.core.environment.laberinto;

import aima.core.search.framework.evalfunc.HeuristicFunction;


public class LaberintoManhattanHeuristic implements HeuristicFunction {

    // Returns the manhattan distance to objective 
    //asumimos que no hay punto k
    @Override
    public double h(Object state) {
            LaberintoBoard board = (LaberintoBoard) state;
            //return (board.getRow() + 9 - board.getCol());
            return Math.abs(board.getGoalx() - board.getRow() + board.getGoaly() - board.getCol());
    }
}
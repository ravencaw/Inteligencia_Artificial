package aima.core.environment.Labyrinth;

import aima.core.search.framework.evalfunc.HeuristicFunction;

/**
 * @author Ravi Mohan
 * 
 */
public class LabyrinthManhattanHeuristic implements HeuristicFunction {

    // Returns the manhattan distance to objective 
    public double h(Object state) {
            LabyrinthBoard board = (LabyrinthBoard) state;
            return (board.getRow() + 9 - board.getCol());
            //return Math.abs(destiny.x - board.getRow() + destiny.y - board.getCol());
    }
}
package aima.core.environment.Labyrinth;

import java.util.ArrayList;
import java.util.List;

import aima.core.agent.Action;
import aima.core.agent.impl.DynamicAction;
import aima.core.util.datastructure.XYLocation;

/**
 * @author Ravi Mohan
 * @author R. Lunde
 */
public class LabyrinthBoard {

    public static Action LEFT = new DynamicAction("Left");

    public static Action RIGHT = new DynamicAction("Right");

    public static Action UP = new DynamicAction("Up");

    public static Action DOWN = new DynamicAction("Down");

    private static char[][] state = new char[][]{
        {'O', 'X', 'O', 'O', 'O', 'X', 'X', 'O', 'X', 'O'},
        {'O', 'X', 'O', 'X', 'O', 'O', 'O', 'O', 'X', 'O'},
        {'O', 'X', 'O', 'X', 'O', 'X', 'X', 'X', 'X', 'O'},
        {'O', 'X', 'O', 'X', 'X', 'X', 'O', 'O', 'O', 'O'},
        {'O', 'O', 'O', 'O', 'O', 'X', 'O', 'X', 'O', 'X'},
        {'O', 'X', 'X', 'X', 'O', 'X', 'O', 'X', 'O', 'X'},
        {'O', 'X', 'O', 'O', 'O', 'X', 'O', 'X', 'O', 'X'},
        {'O', 'X', 'O', 'X', 'X', 'X', 'O', 'X', 'O', 'X'},
        {'O', 'X', 'O', 'O', 'O', 'O', 'O', 'X', 'O', 'X'},
        {'O', 'X', 'O', 'X', 'X', 'X', 'X', 'X', 'O', 'X'}
    };
    private int row;
    private int col;

    //
    // PUBLIC METHODS
    //
    public LabyrinthBoard() {
        // Starting position
        this.row = 4;
        this.col = 0;
    }

    public LabyrinthBoard(int x, int y) {
        this.row = x;
        this.col = y;
    }

    public LabyrinthBoard(LabyrinthBoard copyBoard) {
        this(copyBoard.getRow(), copyBoard.getCol());
    }

    public int getRow() {
        return row;
    }

    public void setRow(int row) {
        this.row = row;
    }

    public int getCol() {
        return col;
    }

    public void setCol(int col) {
        this.col = col;
    }

    public void moveGapRight() {
        this.col++;

    }

    public void moveGapLeft() {
        this.col--;
    }

    public void moveGapDown() {
        this.row++;
    }

    public void moveGapUp() {
        this.row--;
    }

    // Check if we are in board edge (eg col=0) OR if there is an X where we want to go
    public boolean canMoveGap(Action where) {
        boolean retVal = true;
        if (where.equals(LEFT)) {
            retVal = (getCol() != 0)
                    && (state[this.getRow()][this.getCol() - 1] != 'X');
        } else if (where.equals(RIGHT)) {
            retVal = (getCol() != 9)
                    && (state[this.getRow()][this.getCol() + 1] != 'X');
        } else if (where.equals(UP)) {
            retVal = (getRow() != 0)
                    && (state[this.getRow()-1][this.getCol()] != 'X');
        } else if (where.equals(DOWN)) {
            retVal = (getRow() != 9)
                    && (state[this.getRow()+1][this.getCol()] != 'X');
        }
        return retVal;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 67 * hash + this.row;
        hash = 67 * hash + this.col;
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final LabyrinthBoard other = (LabyrinthBoard) obj;
        if (this.row != other.row) {
            return false;
        }
        if (this.col != other.col) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "LabyrinthBoard{" + "row=" + row + ", col=" + col + '}';
    } 
}

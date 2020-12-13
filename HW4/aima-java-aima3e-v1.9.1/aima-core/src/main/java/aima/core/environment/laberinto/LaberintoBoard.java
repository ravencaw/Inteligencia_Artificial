package aima.core.environment.laberinto;

import aima.core.agent.Action;
import aima.core.agent.impl.DynamicAction;

public class LaberintoBoard {

    public static Action UP = new DynamicAction("up");
    public static Action DOWN = new DynamicAction("down");
    public static Action LEFT = new DynamicAction("left");
    public static Action RIGHT = new DynamicAction("right");

    private int row;
    private int col;

    private static char state[][] = {
        {'S', '0', '0', '%'},
        {'0', '%', '0', '%'},
        {'%', 'K', '0', '%'},
        {'%', '0', '0', 'G'}
    };

    public LaberintoBoard() {
        this.row = 0;
        this.col = 0;
    }

    public LaberintoBoard(int r, int c) {
        this.row = r;
        this.col = c;
    }

    public LaberintoBoard(LaberintoBoard copyBoard) {
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

    public static void setValueState(int i, int j) {
        if (state[i][j] != '%') {
            state[i][j] = '.';
        }
    }

    public static char getValueState(int i, int j) {
        return state[i][j];
    }

    public void moveRight() {
        this.row++;
    }

    public void moveLeft() {
        this.row--;
    }

    public void moveDown() {
        this.col++;
    }

    public void moveUp() {
        this.col--;
    }

    public boolean canMove(Action where) {

        boolean res = false;

        if (where.equals(UP)) {
            res = (getRow() != 0) && (state[getRow() - 1][getCol()] != '%');
        } else if (where.equals(DOWN)) {
            res = (getRow() != state.length - 1) && (state[getRow() + 1][getCol()] != '%');
        } else if (where.equals(LEFT)) {
            res = (getCol() != 0) && (state[getRow()][getCol() - 1] != '%');
        } else if (where.equals(RIGHT)) {
            res = (getCol() != state.length) && (state[getRow() + 1][getCol()] != '%');
        }

        return res;

    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final LaberintoBoard other = (LaberintoBoard) obj;
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
        return "LaberintoBoard{" + "row=" + row + ", col=" + col + '}';
    }

}

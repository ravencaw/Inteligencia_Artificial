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
        {'S', ' ', ' ', '%'},
        {' ', '%', ' ', '%'},
        {'%', 'K', ' ', '%'},
        {'%', ' ', ' ', 'G'}
    };

    /*
    constructor incompleto hay que asignar el punto de inicio dinamicamente
     */
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

    public boolean isKPassed(int i, int j) {
        if (state[i][j] == '.') {
            return true;
        } else {
            return false;
        }
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
       setValueState(row, col);
       this.row++;
       
    }

    public void moveLeft() {
        setValueState(row, col);
        this.row--;
        
    }

    public void moveDown() {
        setValueState(row, col);
        this.col++;
        
    }

    public void moveUp() {
        setValueState(row, col);
        this.col--;
        
    }

    public boolean canMove(Action where) {

        boolean res = false;

        if (where.equals(UP)) {
            if (getRow() != 0) {
                if (state[getRow() - 1][getCol()] != '%' && state[getRow() - 1][getCol()] != '.') {
                    res = true;
                }
            }
            //res = (getRow() != 0) && (state[getRow() - 1][getCol()] != '%');
        } else if (where.equals(DOWN)) {
            if (getRow() != state.length - 1) {
                if (state[getRow() + 1][getCol()] != '%' && state[getRow() + 1][getCol()] != '.') {
                    res = true;
                }
            }
            //res = (getRow() != state.length - 1) && (state[getRow() + 1][getCol()] != '%');
        } else if (where.equals(LEFT)) {
            if (getCol() != 0) {
                if (state[getRow()][getCol() - 1] != '%' && state[getRow()][getCol() - 1] != '.') {
                    res = true;
                }
            }
            //res = (getCol() != 0) && (state[getRow()][getCol() - 1] != '%');
        } else if (where.equals(RIGHT)) {
            if (getCol() != state.length - 1) {
                if (state[getRow()][getCol() + 1] != '%' && state[getRow()][getCol() + 1] != '.') {
                    res = true;
                }
            }

            //res = (getCol() != state.length-1) && (state[getRow()][getCol() + 1] != '%');
        }

        return res;

    }

    @Override
    public boolean equals(Object obj
    ) {
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

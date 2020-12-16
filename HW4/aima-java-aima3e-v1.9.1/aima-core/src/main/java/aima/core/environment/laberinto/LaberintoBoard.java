package aima.core.environment.laberinto;

import aima.core.agent.Action;
import aima.core.agent.impl.DynamicAction;
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.util.Scanner;

public class LaberintoBoard {

    private static String FILENAME = "laberinto.txt";

    public static Action UP = new DynamicAction("up");
    public static Action DOWN = new DynamicAction("down");
    public static Action LEFT = new DynamicAction("left");
    public static Action RIGHT = new DynamicAction("right");

    private int row;
    private int col;
    private int goalx;
    private int goaly;
    private boolean kPassed = false;

    private char state[][];
//    private static char state[][] = {
//        {'S', ' ', ' ', '%'},
//        {' ', '%', ' ', '%'},
//        {'%', 'K', ' ', '%'},
//        {'%', ' ', ' ', 'G'}
//    };

   
    public LaberintoBoard() {
        state = readFile(FILENAME);
        setPoints();
    }

    public LaberintoBoard(int r, int c, boolean k) {
        state = readFile(FILENAME);
        this.row = r;
        this.col = c;
        this.kPassed = k;
    }

    public LaberintoBoard(LaberintoBoard copyBoard) {
        this(copyBoard.getRow(), copyBoard.getCol(), copyBoard.iskPassed());
    }

    private void setPoints() {
        for (int i = 0; i < state.length; i++) {
            for (int j = 0; j < state[i].length; j++) {
                 
                if (state[i][j] == 'S') {
                    this.row = i;
                    this.col = j;
                } else if (state[i][j] == 'G') {
                    this.goalx = i;
                    this.goaly = j;
                }
            }
        }
    }

    public static char[][] readFile(String file) {

        int wid;
        String line = null;
        char[][] newRow = null;

        try{
            String path = System.getProperty("user.dir");
            //System.out.println(path);
            FileReader fileReader = new FileReader(path + "\\aima-java-aima3e-v1.9.1\\aima-core\\src\\main\\java\\aima\\core\\environment\\laberinto\\"+ file);
            
            BufferedReader buffer = new BufferedReader(fileReader);
            Scanner scan = new Scanner(buffer);

            if(scan.hasNextLine()){
                line = scan.nextLine();
                wid = line.length();
                newRow = new char[wid][wid];

                for(int i =0; i<wid;i++){
                    newRow[0][i] = line.charAt(i);
                }

                while(scan.hasNextLine()){
                    
                    for(int i = 1; i<wid;i++){
                        line = scan.nextLine();
                        for(int j = 0; j<wid;j++){
                            newRow[i][j] = line.charAt(j);
                        }
                    }
                }
                scan.close();
            }
        }catch (FileNotFoundException ex){
            System.err.println("No se puede abrir el archivo: "+file);
        }
        
        return newRow;

    }

    public void printPath() {

        for (int i = 0; i < state.length; i++) {
            for (int j = 0; j < state[i].length; j++) {

                System.out.print(state[i][j] + "|");

            }
            System.out.print("\n");
        }

        System.out.println("\n\n");

    }

    public boolean iskPassed() {
        return kPassed;
    }

    public void setkPassed(boolean kPassed) {
        this.kPassed = kPassed;
    }

    public char[][] getState() {
        return state;
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

    public int getGoalx() {
        return goalx;
    }

    public void setGoalx(int goalx) {
        this.goalx = goalx;
    }

    public int getGoaly() {
        return goaly;
    }

    public void setGoaly(int goaly) {
        this.goaly = goaly;
    }

    public void setValueState(int i, int j) {
        if (state[i][j] != '%' && state[i][j] != '.') {
            state[i][j] = '.';
        }
    }

    public char getValueState(int i, int j) {
        return state[i][j];
    }

    public void moveRight() {
        this.col++;
        setValueState(row, col);
        
        if (state[row][col] == 'K') {
            kPassed = true;
        }
    }

    public void moveLeft() {
        this.col--;
        setValueState(row, col);

        if (state[row][col] == 'K') {
            kPassed = true;
        }
    }

    public void moveDown() {
        this.row++;
        setValueState(row, col);

        if (state[row][col] == 'K') {
            kPassed = true;
        }
    }

    public void moveUp() {
        this.row--;
        setValueState(row, col);

        if (state[row][col] == 'K') {
            kPassed = true;
        }
    }

    public boolean canMove(Action where) {

        boolean res = false;

        if (where.equals(UP)) {
            if (this.getRow() > 0) {
                if (state[getRow() - 1][this.getCol()] != '%') {
                    res = true;
                }
            }
            //res = (getRow() != 0) && (state[getRow() - 1][getCol()] != '%');
        } else if (where.equals(DOWN)) {
            if (this.getRow() < state.length - 1) {
                if (state[this.getRow() + 1][this.getCol()] != '%') {
                    res = true;
                }
            }
            //res = (getRow() != state.length - 1) && (state[getRow() + 1][getCol()] != '%');
        } else if (where.equals(LEFT)) {
            if (this.getCol() > 0) {
                if (state[this.getRow()][this.getCol() - 1] != '%') {
                    res = true;
                }
            }
            //res = (getCol() != 0) && (state[getRow()][getCol() - 1] != '%');
        } else if (where.equals(RIGHT)) {
            if (this.getCol() < state[0].length - 1) {
                if (state[this.getRow()][this.getCol() + 1] != '%') {
                    res = true;
                }
            }

            //res = (getCol() != state.length-1) && (state[getRow()][getCol() + 1] != '%');
        }

        return res;

    }

    @Override
    public int hashCode() {
        int hash = 5;
        hash = 83 * hash + this.row;
        hash = 83 * hash + this.col;
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
        final LaberintoBoard other = (LaberintoBoard) obj;
        if (this.row != other.row) {
            return false;
        }
        if (this.col != other.col) {
            return false;
        }
        if (this.kPassed != other.kPassed) {
            return false;
        }
        return true;
    }

}

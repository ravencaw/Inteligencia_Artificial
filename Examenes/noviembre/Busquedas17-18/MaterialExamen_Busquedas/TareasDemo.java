package aima.core.environment.tareas;

import java.util.HashSet;
import java.util.Set;

import aima.core.search.local.Individual;
import java.io.IOException;
import java.math.BigDecimal;

    public class TareasDemo {

    private static final int _boardSize = 4;

    public static void main(String[] args) throws IOException {
        TareasSearch();
    }

    private static void TareasSearch() throws IOException {
        System.out.println("\nDemo Algorithm  -->");
        try {








            System.out.println("Max Time (1 second) Best Individual=\n"
                    + fitnessFunction.getBoardForIndividual(bestIndividual));
            System.out.println("Board Size      = " + _boardSize);
            System.out.println("# Board Layouts = " + (new BigDecimal(_boardSize)).pow(_boardSize));
            System.out.println("Fitness         = " + fitnessFunction.getValue(bestIndividual));
//            System.out.println("Is Goal         = " + goalTest.isGoalState(bestIndividual));
            System.out.println("Population Size = " + ga.getPopulationSize());
            System.out.println("Itertions       = " + ga.getIterations());
            System.out.println("Took            = " + ga.getTimeInMilliseconds() + "ms.");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

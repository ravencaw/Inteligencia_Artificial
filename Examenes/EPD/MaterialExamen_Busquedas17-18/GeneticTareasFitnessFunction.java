package aima.core.environment.tareas;

import aima.core.search.framework.GoalTest;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Random;
import java.util.Set;

import aima.core.search.local.FitnessFunction;
import aima.core.search.local.Individual;
import java.util.Collection;
import java.util.Collections;

public class GeneticTareasFitnessFunction implements FitnessFunction<Integer>, GoalTest {

	private final GeneticTareasGoalTest goalTest = new GeneticTareasGoalTest();

    
    @Override
    public double getValue(Individual<Integer> individual) {


    }

    public static Individual<Integer> generateRandomIndividual(int boardSize) {

    }

    @SuppressWarnings("unchecked")
    public boolean isGoalState(Object state) {
        return goalTest.isGoalState(state);
    }

    public String getBoardForIndividual(Individual<Integer> individual) {
        String s = "";
        for (Integer indi : individual.getRepresentation()) {
            s += indi.toString() + " ";
        }
        return s;
    }

    public static Set<Integer> getFiniteAlphabetForBoardOfSize(int size) {
        Set<Integer> fab = new HashSet<Integer>();

        for (int i = 0; i < size; i++) {
            fab.add(i);
        }

        return fab;
    }
}
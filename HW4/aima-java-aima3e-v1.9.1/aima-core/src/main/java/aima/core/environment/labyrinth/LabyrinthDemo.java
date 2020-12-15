package aima.core.environment.labyrinth;

import java.util.Iterator;
import java.util.List;
import java.util.Properties;

import aima.core.agent.Action;
import aima.core.environment.Labyrinth.LabyrinthBoard;
import aima.core.environment.Labyrinth.LabyrinthFunctionFactory;
import aima.core.environment.Labyrinth.LabyrinthGoalTest;
//import aima.core.environment.Labyrinth.LabyrinthManhattanHeuristic;
//import aima.core.environment.Labyrinth.MisplacedTilleHeuristicFunction;
import aima.core.search.framework.SearchAgent;
import aima.core.search.framework.SearchForActions;
import aima.core.search.framework.problem.Problem;
import aima.core.search.framework.qsearch.GraphSearch;
import aima.core.search.framework.qsearch.TreeSearch;
import aima.core.search.informed.AStarSearch;
import aima.core.search.informed.GreedyBestFirstSearch;
import aima.core.search.local.SimulatedAnnealingSearch;
import aima.core.search.uninformed.BreadthFirstSearch;
import aima.core.search.uninformed.DepthFirstSearch;
import aima.core.search.uninformed.DepthLimitedSearch;
import aima.core.search.uninformed.IterativeDeepeningSearch;

/**
 * @author Ravi Mohan
 *
 */
public class LabyrinthDemo {

    static LabyrinthBoard boardInit = new LabyrinthBoard(4, 0);

    public static void main(String[] args) {
        //LabyrinthDLSDemo();
	//	LabyrinthIDLSDemo();
	//	LabyrinthGreedyBestFirstDemo();
	//	LabyrinthGreedyBestFirstManhattanDemo();
	//	LabyrinthAStarDemo();
	//	LabyrinthAStarManhattanDemo();
	//	LabyrinthSimulatedAnnealingDemo();
        //labyrinthWithBreadthFirstSearch();
        labyrinthWithDepthFirstSearch();
    }

    private static void labyrinthWithBreadthFirstSearch() {
        try {
            System.out.println("\nLabyrinthDemo BFS -->");
            Problem problem = new Problem(new LabyrinthBoard(boardInit), LabyrinthFunctionFactory.getActionsFunction(),
                    LabyrinthFunctionFactory.getResultFunction(), new LabyrinthGoalTest());
            SearchForActions search = new BreadthFirstSearch(new TreeSearch());
            SearchAgent agent = new SearchAgent(problem, search);
            printActions(agent.getActions());
            printInstrumentation(agent.getInstrumentation());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static void labyrinthWithDepthFirstSearch() {
        System.out.println("\nLabyrinthDemo DFS -->");
        try {
            Problem problem = new Problem(new LabyrinthBoard(boardInit), LabyrinthFunctionFactory.getActionsFunction(),
                    LabyrinthFunctionFactory.getResultFunction(), new LabyrinthGoalTest());
            SearchForActions search = new DepthFirstSearch(new GraphSearch());
            SearchAgent agent = new SearchAgent(problem, search);
            printActions(agent.getActions());
            printInstrumentation(agent.getInstrumentation());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static void LabyrinthAStarDemo() {
        System.out.println("\nLabyrinthDemo A* -->");
        try {
            Problem problem = new Problem(new LabyrinthBoard(boardInit), LabyrinthFunctionFactory.getActionsFunction(),
                    LabyrinthFunctionFactory.getResultFunction(), new LabyrinthGoalTest());
            SearchForActions search = new AStarSearch(new GraphSearch(), new LabyrinthManhattanHeuristic());
            SearchAgent agent = new SearchAgent(problem, search);
            printActions(agent.getActions());
            printInstrumentation(agent.getInstrumentation());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
        private static void LabyrinthGreedyBestFirstDemo() {
        System.out.println("\nLabyrinthDemo GBF -->");
        try {
            Problem problem = new Problem(new LabyrinthBoard(boardInit), LabyrinthFunctionFactory.getActionsFunction(),
                    LabyrinthFunctionFactory.getResultFunction(), new LabyrinthGoalTest());
            SearchForActions search = new GreedyBestFirstSearch(new GraphSearch(), new LabyrinthManhattanHeuristic());
            SearchAgent agent = new SearchAgent(problem, search);
            printActions(agent.getActions());
            printInstrumentation(agent.getInstrumentation());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    private static void printInstrumentation(Properties properties) {
        Iterator<Object> keys = properties.keySet().iterator();
        while (keys.hasNext()) {
            String key = (String) keys.next();
            String property = properties.getProperty(key);
            System.out.println(key + " : " + property);
        }

    }

    private static void printActions(List<Action> actions) {
        for (int i = 0; i < actions.size(); i++) {
            String action = actions.get(i).toString();
            System.out.println(action);
        }
    }

}

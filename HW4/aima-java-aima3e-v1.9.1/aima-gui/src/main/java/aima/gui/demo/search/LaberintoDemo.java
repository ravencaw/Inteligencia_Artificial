package aima.gui.demo.search;

import aima.core.agent.Action;
import aima.core.environment.laberinto.*;
import aima.core.search.framework.SearchAgent;
import aima.core.search.framework.SearchForActions;
import aima.core.search.framework.evalfunc.HeuristicFunction;
import aima.core.search.framework.problem.Problem;
import aima.core.search.framework.qsearch.GraphSearch;
import aima.core.search.framework.qsearch.TreeSearch;
import aima.core.search.informed.AStarSearch;
import aima.core.search.informed.GreedyBestFirstSearch;
import aima.core.search.uninformed.BreadthFirstSearch;
import aima.core.search.uninformed.DepthFirstSearch;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;

public class LaberintoDemo {

    static LaberintoBoard laberintoPrueba = new LaberintoBoard();
    public static int row;
    public static int col;
    private static char[][] path = laberintoPrueba.getState();

    public static void main(String[] args) {
        
        
        labBreadthDemo();
        labDepthDemo();
        LaberintoAStarDemo();
        LaberintoGreedyDemo();
    }

    private static void labBreadthDemo() {
        System.out.println("\nLaberintoDemo breadth -->");
        try {
            Problem problem = new Problem(laberintoPrueba, LaberintoFunctionFactory.getActionsFunction(),
                    LaberintoFunctionFactory.getResultFunction(), new LaberintoGoalTest());

            SearchForActions search = new BreadthFirstSearch(new TreeSearch());
            SearchAgent agent = new SearchAgent(problem, search);
            printActions(agent.getActions());
            printInstrumentation(agent.getInstrumentation());
            ArrayList<Action> actions = (ArrayList<Action>) agent.getActions();
            laberintoPrueba = printPath(actions);
            printSolution();
            //laberintoPrueba.printPath();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static void labDepthDemo() {
        System.out.println("\nLaberintoDemo Depth -->");
        try {
            Problem problem = new Problem(laberintoPrueba, LaberintoFunctionFactory.getActionsFunction(),
                    LaberintoFunctionFactory.getResultFunction(), new LaberintoGoalTest());
            
            SearchForActions search = new DepthFirstSearch(new GraphSearch());
            SearchAgent agent = new SearchAgent(problem, search);
            printActions(agent.getActions());
            printInstrumentation(agent.getInstrumentation());
            ArrayList<Action> actions = (ArrayList<Action>) agent.getActions();
            laberintoPrueba = printPath(actions);
            printSolution();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    private static void LaberintoAStarDemo() {
        System.out.println("\nLabyrinthDemo A* -->");
        try {
            Problem problem = new Problem(new LaberintoBoard(laberintoPrueba), LaberintoFunctionFactory.getActionsFunction(),
                    LaberintoFunctionFactory.getResultFunction(), new LaberintoGoalTest());
            SearchForActions search = new AStarSearch(new GraphSearch(), new LaberintoHeuristicFunction());
            SearchAgent agent = new SearchAgent(problem, search);
            printActions(agent.getActions());
            printInstrumentation(agent.getInstrumentation());
            ArrayList<Action> actions = (ArrayList<Action>) agent.getActions();
            laberintoPrueba = printPath(actions);
            printSolution();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    private static void LaberintoGreedyDemo() {
        System.out.println("\nLabyrinthDemo Greedy -->");
        try {
            Problem problem = new Problem(new LaberintoBoard(laberintoPrueba), LaberintoFunctionFactory.getActionsFunction(),
                    LaberintoFunctionFactory.getResultFunction(), new LaberintoGoalTest());
            SearchForActions search = new GreedyBestFirstSearch(new GraphSearch(), new LaberintoHeuristicFunction());
            SearchAgent agent = new SearchAgent(problem, search);
            printActions(agent.getActions());
            printInstrumentation(agent.getInstrumentation());
            ArrayList<Action> actions = (ArrayList<Action>) agent.getActions();
            laberintoPrueba = printPath(actions);
            printSolution();
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
    
    public static LaberintoBoard printPath(List<Action> actions){
        for(int i =0; i<actions.size();i++){
            if(actions.get(i).toString().equals("Action[name==up]")){
                path[laberintoPrueba.getRow()-1][laberintoPrueba.getCol()] = '.';
                laberintoPrueba.setRow(laberintoPrueba.getRow()-1);
            }else if(actions.get(i).toString().equals("Action[name==down]")){
                path[laberintoPrueba.getRow()+1][laberintoPrueba.getCol()] = '.';
                laberintoPrueba.setRow(laberintoPrueba.getRow()+1);
            }else if(actions.get(i).toString().equals("Action[name==left]")){
                path[laberintoPrueba.getRow()][laberintoPrueba.getCol()-1] = '.';
                laberintoPrueba.setCol(laberintoPrueba.getCol()-1);
            }else{
                path[laberintoPrueba.getRow()][laberintoPrueba.getCol()+1] = '.';
                laberintoPrueba.setCol(laberintoPrueba.getCol()+1);
            }
        }
        row = laberintoPrueba.getRow();
        col = laberintoPrueba.getCol();

        return laberintoPrueba;
    }
    
    public static void printSolution(){
        System.out.print("\n");

        for(int i = 0; i < path.length; i++)
        {
            for(int j = 0; j < path[i].length; j++)
            {
                System.out.printf("|%c|\t", path[i][j]);
            }
            System.out.print("\n");
        }
    }


}

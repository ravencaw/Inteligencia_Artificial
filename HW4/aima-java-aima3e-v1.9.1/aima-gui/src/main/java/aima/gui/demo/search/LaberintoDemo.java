package aima.gui.demo.search;

import aima.core.agent.Action;
import aima.core.environment.laberinto.*;
import aima.core.search.framework.SearchAgent;
import aima.core.search.framework.SearchForActions;
import aima.core.search.framework.problem.Problem;
import aima.core.search.uninformed.BreadthFirstSearch;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;

public class LaberintoDemo {

    static LaberintoBoard laberintoPrueba = new LaberintoBoard();

    public static void main(String[] args) {
        labBreadthDemo();
    }

    private static void labBreadthDemo() {
        System.out.println("\nLaberintoDemo breadth -->");
        try {
            Problem problem = new Problem(laberintoPrueba, LaberintoFunctionFactory.getActionsFunction(),
                    LaberintoFunctionFactory.getResultFunction(), new LaberintoGoalTest());

            SearchForActions search = new BreadthFirstSearch();
            SearchAgent agent = new SearchAgent(problem, search);
            printActions(agent.getActions());
            printInstrumentation(agent.getInstrumentation());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static void labDepthDemo() {

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

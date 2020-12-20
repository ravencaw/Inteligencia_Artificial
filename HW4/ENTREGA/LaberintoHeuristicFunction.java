/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aima.core.environment.laberinto;

import aima.core.search.framework.evalfunc.HeuristicFunction;

/**
 *
 * @author geral
 */
public class LaberintoHeuristicFunction implements HeuristicFunction{
    
    @Override
    public double h(Object state) {
        LaberintoBoard board = (LaberintoBoard) state;
        return getNodesLeft(board);
    }

    private int getNodesLeft(LaberintoBoard board) {
        //calculamos num personas
        char [][] state = board.getState();
        int left = 0;
        
        for(int i = 0 ; i < state.length - 1;i++){
           for(int j=0; j<state[i].length -1 ;j++){
               
               if(state[i][j] == ' '){
                   left++;
               }
               
           }
        }
        
        return left;
    }
    
}

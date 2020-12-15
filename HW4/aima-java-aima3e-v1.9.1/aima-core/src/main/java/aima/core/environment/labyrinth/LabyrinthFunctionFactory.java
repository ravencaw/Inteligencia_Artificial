/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aima.core.environment.Labyrinth;

import java.util.LinkedHashSet;
import java.util.Set;

import aima.core.agent.Action;
import aima.core.search.framework.problem.ActionsFunction;
import aima.core.search.framework.problem.ResultFunction;

/**
 * @author Ravi Mohan
 * @author Ciaran O'Reilly
 */
public class LabyrinthFunctionFactory {
	private static ActionsFunction _actionsFunction = null;
	private static ResultFunction _resultFunction = null;

	public static ActionsFunction getActionsFunction() {
		if (null == _actionsFunction) {
			_actionsFunction = new EPActionsFunction();
		}
		return _actionsFunction;
	}

	public static ResultFunction getResultFunction() {
		if (null == _resultFunction) {
			_resultFunction = new EPResultFunction();
		}
		return _resultFunction;
	}

	private static class EPActionsFunction implements ActionsFunction {
		public Set<Action> actions(Object state) {
			LabyrinthBoard board = (LabyrinthBoard) state;

			Set<Action> actions = new LinkedHashSet<Action>();

			if (board.canMoveGap(LabyrinthBoard.UP)) {
				actions.add(LabyrinthBoard.UP);
			}
			if (board.canMoveGap(LabyrinthBoard.DOWN)) {
				actions.add(LabyrinthBoard.DOWN);
			}
			if (board.canMoveGap(LabyrinthBoard.LEFT)) {
				actions.add(LabyrinthBoard.LEFT);
			}
			if (board.canMoveGap(LabyrinthBoard.RIGHT)) {
				actions.add(LabyrinthBoard.RIGHT);
			}

			return actions;
		}
	}

	private static class EPResultFunction implements ResultFunction {
		public Object result(Object s, Action a) {
			LabyrinthBoard board = (LabyrinthBoard) s;

			if (LabyrinthBoard.UP.equals(a)
					&& board.canMoveGap(LabyrinthBoard.UP)) {
				LabyrinthBoard newBoard = new LabyrinthBoard(board);
				newBoard.moveGapUp();
				return newBoard;
			} else if (LabyrinthBoard.DOWN.equals(a)
					&& board.canMoveGap(LabyrinthBoard.DOWN)) {
				LabyrinthBoard newBoard = new LabyrinthBoard(board);
				newBoard.moveGapDown();
				return newBoard;
			} else if (LabyrinthBoard.LEFT.equals(a)
					&& board.canMoveGap(LabyrinthBoard.LEFT)) {
				LabyrinthBoard newBoard = new LabyrinthBoard(board);
				newBoard.moveGapLeft();
				return newBoard;
			} else if (LabyrinthBoard.RIGHT.equals(a)
					&& board.canMoveGap(LabyrinthBoard.RIGHT)) {
				LabyrinthBoard newBoard = new LabyrinthBoard(board);
				newBoard.moveGapRight();
				return newBoard;
			}

			// The Action is not understood or is a NoOp
			// the result will be the current state.
			return s;
		}
	}
}
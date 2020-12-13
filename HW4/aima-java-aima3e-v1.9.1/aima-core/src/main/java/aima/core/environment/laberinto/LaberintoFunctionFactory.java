package aima.core.environment.laberinto;

import java.util.LinkedHashSet;
import java.util.Set;

import aima.core.agent.Action;
import aima.core.search.framework.problem.ActionsFunction;
import aima.core.search.framework.problem.ResultFunction;


public class LaberintoFunctionFactory {
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
			LaberintoBoard board = (LaberintoBoard) state;

			Set<Action> actions = new LinkedHashSet<Action>();

			if (board.canMove(LaberintoBoard.UP)) {
				actions.add(LaberintoBoard.UP);
			}
			if (board.canMove(LaberintoBoard.DOWN)) {
				actions.add(LaberintoBoard.DOWN);
			}
			if (board.canMove(LaberintoBoard.LEFT)) {
				actions.add(LaberintoBoard.LEFT);
			}
			if (board.canMove(LaberintoBoard.RIGHT)) {
				actions.add(LaberintoBoard.RIGHT);
			}

			return actions;
		}
	}

	private static class EPResultFunction implements ResultFunction {
		public Object result(Object s, Action a) {
			LaberintoBoard board = (LaberintoBoard) s;

			if (LaberintoBoard.UP.equals(a)
					&& board.canMove(LaberintoBoard.UP)) {
				LaberintoBoard newBoard = new LaberintoBoard(board);
				newBoard.moveUp();
				return newBoard;
			} else if (LaberintoBoard.DOWN.equals(a)
					&& board.canMove(LaberintoBoard.DOWN)) {
				LaberintoBoard newBoard = new LaberintoBoard(board);
				newBoard.moveDown();
				return newBoard;
			} else if (LaberintoBoard.LEFT.equals(a)
					&& board.canMove(LaberintoBoard.LEFT)) {
				LaberintoBoard newBoard = new LaberintoBoard(board);
				newBoard.moveLeft();
				return newBoard;
			} else if (LaberintoBoard.RIGHT.equals(a)
					&& board.canMove(LaberintoBoard.RIGHT)) {
				LaberintoBoard newBoard = new LaberintoBoard(board);
				newBoard.moveRight();
				return newBoard;
			}

			// The Action is not understood or is a NoOp
			// the result will be the current state.
			return s;
		}
	}
}
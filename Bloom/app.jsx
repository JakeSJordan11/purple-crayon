import * as React from "react";
import * as ReactDOM from "react-dom/client";
import { AiOutlineSwitcher } from "react-icons/ai";
import {
  FaArrowsAlt,
  FaBackspace,
  FaCross,
  FaFill,
  FaFillDrip,
  FaPaintBrush,
  FaPenNib,
  FaRedoAlt,
  FaUndoAlt,
} from "react-icons/fa";
import { LuCircleX, LuCommand, LuLassoSelect, LuOption } from "react-icons/lu";
import "./app.css";

function App() {
  const [EditMode, setEditMode] = React.useState(false);
  const [AcitveWorkspace, setActiveWorkspace] = React.useState("Photoshop");

  function handleMouseDown(button, modifiers) {
    if (!window.webkit.messageHandlers.buttonClicked) return;

    window.webkit.messageHandlers.buttonClicked.postMessage({
      keyCode: button,
      modifiers: modifiers,
    });
  }

  return (
    <>
      {EditMode ? (
        <menu className="tabbar">
          <button
            className="tab"
            onMouseDown={() => {
              (setActiveWorkspace("Ableton Live"), setEditMode(!EditMode));
            }}
          >
            Ableton Live
          </button>
          <button
            className="tab"
            onMouseDown={() => {
              (setActiveWorkspace("Photoshop"), setEditMode(!EditMode));
            }}
          >
            Photoshop
          </button>
          <button
            className="tab"
            onMouseDown={() => setActiveWorkspace("User")}
          >
            +
          </button>
        </menu>
      ) : null}
      <button
        className="activeWorkspace"
        onMouseDown={() => setTimeout(() => setEditMode(!EditMode), 200)}
      >
        {EditMode ? "Edit" : AcitveWorkspace}
      </button>
      <button
        title="pen"
        className="user"
        style={{ transform: "translateX(100px)" }}
        onMouseDown={() => handleMouseDown(35)}
      >
        <FaPenNib />
      </button>
      <button
        title="brush"
        className="user"
        style={{ transform: "translateX(-100px)" }}
        onMouseDown={() => handleMouseDown(11)}
      >
        <FaPaintBrush />
      </button>
      <button
        title="lasso"
        className="user"
        style={{ transform: "translateY(100px)" }}
        onMouseDown={() => handleMouseDown(37)}
      >
        <LuLassoSelect />
      </button>
      <button
        title="move"
        className="user"
        style={{ transform: "translateY(-100px)" }}
        onMouseDown={() => handleMouseDown(9)}
      >
        <FaArrowsAlt />
      </button>
      <button
        title="undo"
        className="user"
        style={{ transform: "translate(75px, 75px)" }}
        onMouseDown={() => handleMouseDown(6, "Command")}
      >
        <FaUndoAlt />
      </button>
      <button
        title="redo"
        className="user"
        style={{ transform: "translate(-75px, -75px)" }}
        onMouseDown={() => handleMouseDown(6, "Command, Shift")}
      >
        <FaRedoAlt />
      </button>
      <button
        title="switch"
        className="user"
        style={{ transform: "translate(75px, -75px)" }}
        onMouseDown={() => handleMouseDown(7)}
      >
        <AiOutlineSwitcher />
      </button>
      <button
        title="backspace"
        className="user"
        style={{ transform: "translate(-75px, 75px)" }}
        onMouseDown={() => handleMouseDown(51)}
      >
        <FaBackspace />
      </button>
      <button
        title="fill"
        className="user"
        style={{ transform: "translate(0px, -175px)" }}
        onMouseDown={() => handleMouseDown(51, "Alternate")}
      >
        <FaFill />
      </button>
      <button
        title="fill"
        className="user"
        style={{ transform: "translateY(175px)" }}
        onMouseDown={() => handleMouseDown(51, "Command")}
      >
        <FaFillDrip />
      </button>
      <button
        title="alternate"
        className="user"
        style={{ transform: "translateX(175px)" }}
        onMouseDown={() => handleMouseDown(58)}
      >
        <LuOption />
      </button>
      <button
        title="command"
        className="user"
        style={{ transform: "translateX(-175px)" }}
        onMouseDown={() => handleMouseDown(55)}
      >
        <LuCommand />
      </button>
    </>
  );
}

ReactDOM.createRoot(document.getElementById("root")).render(<App />);

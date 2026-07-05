import * as React from "react";
import * as ReactDOM from "react-dom/client";
import { AiOutlineSwitcher } from "react-icons/ai";
import {
  FaArrowsAlt,
  FaPaintBrush,
  FaPenNib,
  FaRedoAlt,
  FaUndoAlt,
} from "react-icons/fa";
import { LuLassoSelect } from "react-icons/lu";
import "./app.css";

function App() {
  function handleMouseDown(button, modifiers = "") {
    if (!window.webkit.messageHandlers.buttonClicked) return;

    window.webkit.messageHandlers.buttonClicked.postMessage({
      keyCode: button,
      modifiers: modifiers, // String with comma-separated modifiers like "Cmd,Shift"
    });
  }

  const Workspace = "Photoshop"; // TODO: change to actual workspace name from the system

  return (
    <>
      <button className="workspace" onMouseDown={null}>
        {Workspace}
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
        onMouseDown={() => handleMouseDown(6, "Cmd")}
      >
        <FaUndoAlt />
      </button>
      <button
        title="redo"
        className="user"
        style={{ transform: "translate(-75px, -75px)" }}
        onMouseDown={() => handleMouseDown(6, "Cmd, Shift")}
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
        className="slot"
        style={{ transform: "translate(-75px, 75px)" }}
      />
    </>
  );
}
ReactDOM.createRoot(document.getElementById("root")).render(<App />);

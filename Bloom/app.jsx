import * as React from "react";
import * as ReactDOM from "react-dom/client";
import "./app.css";

function App() {
  function handleMouseDown(button) {
    if (!window.webkit.messageHandlers.buttonClicked) return;
    window.webkit.messageHandlers.buttonClicked.postMessage(button);
  }

  return (
    <main className="main">
      <button className="pen" onMouseDown={() => handleMouseDown(35)}>
        ✒️
      </button>
      <button className="brush" onMouseDown={() => handleMouseDown(11)}>
        🖌️
      </button>
      <button className="fill" onMouseDown={() => handleMouseDown(0)}>
        🪣
      </button>
    </main>
  );
}
ReactDOM.createRoot(document.getElementById("root")).render(<App />);

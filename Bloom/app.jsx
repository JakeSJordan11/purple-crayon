import * as React from "react";
import * as ReactDOM from "react-dom/client";
import "./app.css";

function App() {
  function handleClick() {
    if (!window.webkit) return;
    if (!window.webkit.messageHandlers) return;
    if (!window.webkit.messageHandlers.buttonClicked) return;
    window.webkit.messageHandlers.buttonClicked.postMessage(
      "Hello from React!",
    );
  }

  function handleMouseEnter(event) {
    ((event.currentTarget.style.letterSpacing = "3px"),
      (event.currentTarget.style.backgroundColor = "hsl(261deg 80% 48%)"),
      (event.currentTarget.style.color = "hsl(0, 0%, 100%)"),
      (event.currentTarget.style.boxShadow =
        "rgb(93 24 220) 0px 7px 29px 0px"));
  }

  function handleMouseLeave(event) {
    ((event.currentTarget.style.letterSpacing = "1.5px"),
      (event.currentTarget.style.backgroundColor = "white"),
      (event.currentTarget.style.color = "initial"),
      (event.currentTarget.style.boxShadow = "rgb(0 0 0 / 5%) 0 0 8px"));
  }

  function handleMouseDown(event) {
    ((event.currentTarget.style.letterSpacing = "3px"),
      (event.currentTarget.style.backgroundColor = "hsl(261deg 80% 48%)"),
      (event.currentTarget.style.color = "hsl(0, 0%, 100%)"),
      (event.currentTarget.style.boxShadow = "rgb(93 24 220) 0px 0px 0px 0px"),
      (event.currentTarget.style.transform = "translateY(10px)"),
      (event.currentTarget.style.transition = "100ms"));
  }

  function handleMouseUp(event) {
    ((event.currentTarget.style.letterSpacing = "3px"),
      (event.currentTarget.style.backgroundColor = "hsl(261deg 80% 48%)"),
      (event.currentTarget.style.color = "hsl(0, 0%, 100%)"),
      (event.currentTarget.style.boxShadow =
        "rgb(93 24 220) 0px 7px 29px 0px"));
    ((event.currentTarget.style.transform = "translateY(-10px)"),
      (event.currentTarget.style.transition = "all 0.5s ease"));
  }

  return (
    <>
      <main className="main">
        <button
          style={{
            padding: "17px 40px",
            borderRadius: "50px",
            cursor: "pointer",
            border: 0,
            backgroundColor: "white",
            boxShadow: "rgb(0 0 0 / 5%) 0 0 8px",
            letterSpacing: "1.5px",
            textTransform: "uppercase",
            fontSize: "15px",
            transition: "all 0.5s ease",
          }}
          onMouseEnter={handleMouseEnter}
          onMouseLeave={handleMouseLeave}
          onMouseDown={handleMouseDown}
          onMouseUp={handleMouseUp}
          onClick={handleClick}
        >
          Button
        </button>
      </main>
    </>
  );
}
ReactDOM.createRoot(document.getElementById("root")).render(<App />);
document.addEventListener("click", (e) => console.log("click", e.target), true);

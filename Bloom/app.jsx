import * as React from "react";
import * as ReactDOM from "react-dom/client";

function App() {
  return (
    <>
      <main
        style={{
          display: "flex",
          justifyContent: "center",
          alignItems: "center",
          height: "100vh",
        }}
      >
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
          onMouseEnter={(e) => {
            ((e.currentTarget.style.letterSpacing = "3px"),
              (e.currentTarget.style.backgroundColor = "hsl(261deg 80% 48%)"),
              (e.currentTarget.style.color = "hsl(0, 0%, 100%)"),
              (e.currentTarget.style.boxShadow =
                "rgb(93 24 220) 0px 7px 29px 0px"));
          }}
          onMouseLeave={(e) => {
            ((e.currentTarget.style.letterSpacing = "1.5px"),
              (e.currentTarget.style.backgroundColor = "white"),
              (e.currentTarget.style.color = "initial"),
              (e.currentTarget.style.boxShadow = "rgb(0 0 0 / 5%) 0 0 8px"));
          }}
          onMouseDown={(e) => {
            ((e.currentTarget.style.letterSpacing = "3px"),
              (e.currentTarget.style.backgroundColor = "hsl(261deg 80% 48%)"),
              (e.currentTarget.style.color = "hsl(0, 0%, 100%)"),
              (e.currentTarget.style.boxShadow =
                "rgb(93 24 220) 0px 0px 0px 0px"),
              (e.currentTarget.style.transform = "translateY(10px)"),
              (e.currentTarget.style.transition = "100ms"));
          }}
          onMouseUp={(e) => {
            ((e.currentTarget.style.letterSpacing = "3px"),
              (e.currentTarget.style.backgroundColor = "hsl(261deg 80% 48%)"),
              (e.currentTarget.style.color = "hsl(0, 0%, 100%)"),
              (e.currentTarget.style.boxShadow =
                "rgb(93 24 220) 0px 7px 29px 0px"));
            ((e.currentTarget.style.transform = "translateY(-10px)"),
              (e.currentTarget.style.transition = "all 0.5s ease"));
          }}
          onClick={(event) => {
            console.log(
              "Clicked"
            )
          }}
        >
          Button
        </button>
      </main>
    </>
  );
}
ReactDOM.createRoot(document.getElementById("root")).render(<App />);
document.addEventListener("click", (e) => console.log("click", e.target), true);

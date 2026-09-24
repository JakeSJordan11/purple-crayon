import * as React from "react";
import * as ReactDOM from "react-dom/client";
import { workspaces } from "./workspaces";
import "./app.css";

const HOLD_MS = 400;

// action is "down" or "up" for held keys; omitted for a normal press
function send(keyCode, modifiers, action) {
  window.webkit?.messageHandlers?.buttonClicked?.postMessage({
    keyCode,
    modifiers,
    action,
  });
}

function StickyButton({ button, active, onToggle }) {
  const { title, icon: Icon, x = 0, y = 0 } = button;
  const timer = React.useRef(null);
  const cancel = () => clearTimeout(timer.current);

  return (
    <button
      title={title}
      className={active ? "user active" : "user"}
      style={{ transform: `translate(${x}px, ${y}px)` }}
      onContextMenu={(e) => e.preventDefault()}
      onPointerDown={() => {
        if (active) return onToggle(button); // tap while on: release
        timer.current = setTimeout(() => onToggle(button), HOLD_MS); // hold while off: lock
      }}
      onPointerUp={cancel}
      onPointerLeave={cancel}
      onPointerCancel={cancel}
    >
      <Icon />
    </button>
  );
}

function Workspace({ buttons, heldKeys, toggleModifier }) {
  return buttons.map((button) => {
    if (button.modifier) {
      return (
        <StickyButton
          key={button.title}
          button={button}
          active={heldKeys.includes(button.keyCode)}
          onToggle={toggleModifier}
        />
      );
    }

    const { title, icon: Icon, x = 0, y = 0, keyCode, modifiers } = button;
    return (
      <button
        key={title}
        title={title}
        className="user"
        style={{ transform: `translate(${x}px, ${y}px)` }}
        onMouseDown={() => send(keyCode, modifiers)}
      >
        <Icon />
      </button>
    );
  });
}

function App() {
  const [editMode, setEditMode] = React.useState(false);
  const [activeWorkspace, setActiveWorkspace] = React.useState("Photoshop");
  const [heldKeys, setHeldKeys] = React.useState([]);

  function toggleModifier({ keyCode }) {
    const turnOn = !heldKeys.includes(keyCode);
    setHeldKeys(
      turnOn ? [...heldKeys, keyCode] : heldKeys.filter((k) => k !== keyCode),
    );
    send(keyCode, undefined, turnOn ? "down" : "up");
  }

  return (
    <>
      {editMode && (
        <menu className="tabbar">
          {Object.keys(workspaces).map((name) => (
            <button
              key={name}
              className="tab"
              onMouseDown={() => {
                setActiveWorkspace(name);
                setEditMode(false);
              }}
            >
              {name}
            </button>
          ))}
        </menu>
      )}

      <button
        className="activeWorkspace"
        onMouseDown={() => setTimeout(() => setEditMode(!editMode), 200)}
      >
        {editMode ? "Edit" : activeWorkspace}
      </button>

      <Workspace
        buttons={workspaces[activeWorkspace]}
        heldKeys={heldKeys}
        toggleModifier={toggleModifier}
      />
    </>
  );
}

ReactDOM.createRoot(document.getElementById("root")).render(<App />);

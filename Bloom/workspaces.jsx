import * as React from "react";
import { AiOutlineSwitcher } from "react-icons/ai";
import {
  FaArrowsAlt,
  FaBackspace,
  FaClone,
  FaCut,
  FaExpand,
  FaFill,
  FaFillDrip,
  FaPaintBrush,
  FaPenNib,
  FaPlay,
  FaRedoAlt,
  FaSyncAlt,
  FaUndoAlt,
} from "react-icons/fa";
import {
  LuArrowBigUp,
  LuChevronUp,
  LuCommand,
  LuLassoSelect,
  LuOption,
} from "react-icons/lu";

// Simple letter icon for key buttons
const letter = (char) => () => <b>{char}</b>;

// Shared buttons, reused across workspaces
const undo = {
  title: "undo",
  icon: FaUndoAlt,
  x: 75,
  y: 75,
  keyCode: 6,
  modifiers: "Command",
};
const redo = {
  title: "redo",
  icon: FaRedoAlt,
  x: -75,
  y: -75,
  keyCode: 6,
  modifiers: "Command, Shift",
};

// Sticky modifiers: `modifier` marks them, keyCode is the key that gets held down
const command = {
  title: "command",
  icon: LuCommand,
  modifier: true,
  keyCode: 55,
};
const shift = {
  title: "shift",
  icon: LuArrowBigUp,
  modifier: true,
  keyCode: 56,
};
const option = { title: "option", icon: LuOption, modifier: true, keyCode: 58 };
const control = {
  title: "control",
  icon: LuChevronUp,
  modifier: true,
  keyCode: 59,
};

export const workspaces = {
  "Ableton Live": [
    { title: "play / stop", icon: FaPlay, x: 100, y: 0, keyCode: 49 },
    { title: "draw mode", icon: FaPenNib, x: -100, y: 0, keyCode: 11 },
    {
      title: "loop selection",
      icon: FaSyncAlt,
      x: 0,
      y: 100,
      keyCode: 37,
      modifiers: "Command",
    },
    {
      title: "session / arrangement",
      icon: AiOutlineSwitcher,
      x: 0,
      y: -100,
      keyCode: 48,
    },
    {
      title: "split",
      icon: FaCut,
      x: 75,
      y: -75,
      keyCode: 14,
      modifiers: "Command",
    },
    {
      title: "duplicate",
      icon: FaClone,
      x: -75,
      y: 75,
      keyCode: 2,
      modifiers: "Command",
    },
    { ...option, x: 175, y: 0 },
    { ...command, x: -175, y: 0 },
    { ...shift, x: 125, y: -125 },
    { ...control, x: -125, y: 125 },
    undo,
    redo,
  ],

  "Nomad Sculpt": [
    { title: "focus", icon: FaExpand, x: 0, y: -100, keyCode: 49 },
    { title: "front / back", icon: letter("F"), x: 100, y: 0, keyCode: 3 },
    { title: "left / right", icon: letter("L"), x: -100, y: 0, keyCode: 37 },
    { title: "top / bottom", icon: letter("T"), x: 0, y: 100, keyCode: 17 },
    { ...option, x: 175, y: 0 },
    { ...command, x: -175, y: 0 },
    { ...shift, x: 125, y: -125 },
    { ...control, x: -125, y: 125 },
    undo,
    redo,
  ],

  Photoshop: [
    { title: "pen", icon: FaPenNib, x: 100, y: 0, keyCode: 35 },
    { title: "brush", icon: FaPaintBrush, x: -100, y: 0, keyCode: 11 },
    { title: "lasso", icon: LuLassoSelect, x: 0, y: 100, keyCode: 37 },
    { title: "move", icon: FaArrowsAlt, x: 0, y: -100, keyCode: 9 },
    { title: "switch", icon: AiOutlineSwitcher, x: 75, y: -75, keyCode: 7 },
    { title: "backspace", icon: FaBackspace, x: -75, y: 75, keyCode: 51 },
    {
      title: "fill foreground",
      icon: FaFill,
      x: 0,
      y: -175,
      keyCode: 51,
      modifiers: "Alternate",
    },
    {
      title: "fill background",
      icon: FaFillDrip,
      x: 0,
      y: 175,
      keyCode: 51,
      modifiers: "Command",
    },
    { ...option, x: 175, y: 0 },
    { ...command, x: -175, y: 0 },
    { ...shift, x: 125, y: -125 },
    { ...control, x: -125, y: 125 },
    undo,
    redo,
  ],
};

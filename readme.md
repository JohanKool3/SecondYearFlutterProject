# Minesweeper [![Codacy Badge](https://app.codacy.com/project/badge/Grade/1ba7472fd1c34d1f9e4b3a87427b5f8d)](https://app.codacy.com/gh/JohanKool3/SecondYearFlutterProject/dashboard?utm_source=gh&utm_medium=referral&utm_content=&utm_campaign=Badge_grade)
**Table of Contents**
- [Controls](#controls)
    - [Mouse Input](#mouse-input)
    - [Keyboard Shortcuts](#keyboard-shortcuts)

- [Input Modes](#input-modes)
    - [Flag Mode](#flag-mode)
    - [Reveal Mode](#reveal-mode)

- [Difficulty Selection](#difficulty-selection)

<a id="controls"></a>

## Controls
To interact with the program the user can either use the mouse to click on the interface or utilize keyboard shortcuts (which will be outlined in the [Keyboard Shortcuts](#keyboard-shortcuts) section)

<a id="mouse-input"></a>

### Mouse Input 
Using any click on a cell will either reveal (if in [reveal mode](#reveal-mode)) or flag that given cell (if in [flag mode](#flag-mode)).



<a id="keyboard-shortcuts"></a>

 ### Keyboard Shortcuts
 To select modes, you can also use the following shortcuts

 - Use the **D** key to change to [flag mode](#flag-mode)

 - Use the **A** key to change to [reveal mode](#reveal-mode))
 - Use the **R** key to **restart the game**
 - Use the **Escape** key to **quit the game**

<a id="input-modes"></a>

## Input Modes
When interacting with a game of minesweeper, the following modes are available

<a id="flag-mode"></a>

### Flag Mode
In this mode, two actions will possibly occur
- **If the cell is unflagged**, a flag will be placed.
- A flag will be placed if **the cell is not flagged**

<a id="reveal-mode"></a>

### Reveal Mode
In this mode, a cell is revealed when it is clicked on. Note:

- If the cell is a **mine**, the game will be over.
- If **flagged**, the cell cannot be revealed until it is **unflagged**

#### Chording
This is a type of input that happens on **revealed** cells (cells where a *number* is revealed).It can be performed when:
- There is an amount of flags surrounding the square **equal to** the amount specified in the revealed cell.

<a id="difficulty-selection"></a>

## Difficulty Selection
To select a difficulty, there will be three buttons underneath the *Grid* that can be pressed. These constitue to [Easy](#easy), [Medium](#medium) and [Hard](#hard) difficulties. Below is the information about each difficulty.


<a id="easy"></a>

### Easy
*This is the simplist difficulty to pick up.*
- There are: **10** Mines.
- The Grid is: **9x9**.

<a id="medium"></a>

### Medium
*The middle of the pack in terms of difficulty.*
- There are: **40** Mines.
- The Grid is: **16x16**

<a id="hard"></a>

### Hard
*The most challenging difficulty.*
- There are: **99** Mines.
- The Grid is: **21x1**
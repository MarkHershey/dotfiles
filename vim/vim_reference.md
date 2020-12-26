# Vim Reference


## NORMAL mode


#### Navigation Commands at NORMAL mode

- `j` move down
- `k` move up
- `h` move left
- `l` move right


- `ctrl` + `u` for **up** a page
- `ctrl` + `d` for **down** a page
- `G` move to the end of the buffer
- `gg` move to the beginning of the buffer
- `L` for **Lower** position on the screen
- `M` for **Middle** position on the screen
- `H` for **Higher** position on the screen



- `w` for **word**
- `e` for **end** of a word
- `b` for **beginning** of a word


- `0` for start of the line
- `$` for end of the line
- `^` for first char of the line
- `%` for jumping to the other parenthesis


- `f` for **find** next forward char
- `F` for **find** next backward char
- `t` for **to** next forward char
- `T` for **to** next backward char


- `o` for **open** a newline below & switch to INSERT mode
- `O` for **open** a newline above & switch to INSERT mode


#### Editing Commands at NORMAL mode


- `x` delete char
- `s` for **substitute** char (equivalent to `xi`)
- `~` change capitalisation
- `r {new char}` for **replace** char to new char
- `dd` for **delete** current line
- `d {something}` for **delete** something
    - `dw` for **delete word**
    - `de` for **delete** from cursor location to the **end** of the word
    - `d$` for **delete** from cursor location to the **end** of the line
- `cc` for **change** current line (delete the line and switch to INSERT mode)
- `c {something}` for **change** something
    - `cw` for **change word** (delete the word and switch to INSERT mode)
- `y  {something}` for **yank** (copy) something
- `yy` for **yank** (copy) current line
- `p` for **paste**
- `.` for repeat last edit (?)


- `u` for **undo**
- `ctrl` + `r` for **redo**

## COMMAND mode

- `:` enters COMMAND mode from NORMAL mode


- `q` for **quit**
- `q!` for force **quit** with out saving
- `w` for **write**
- `wq` for **write and quit**



## VISUAL mode

- `v` enters VISUAL mode from NORMAL mode
- `V` enters VISUAL LINE mode from NORMAL mode
- `ctrl` + 'v' enters VISUAL BLOCK mode from NORMAL mode

## REPLACE mode

- `R` enters REPLACE mode from NORMAL mode


## Count

- `{number}` + `{command}` for executing certain command certain number of times
    - `7j` for moving 7 lines downwards
    - `d5w` for **delete 5 words**
    - `c2w` for **change 2 words**

## Modifiers

- `i` for **inside**
    - `ci(` for **change inside ( )**
    - `di[` for **delete inside [ ]**
- `a` for **around**
    - `da"` for **delete** a double quoted string including **" "** sign

## Windows Management

- `:sp` for **split** window

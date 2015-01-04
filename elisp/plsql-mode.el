(defvar plsql-mode-hook nil
  "*Hook run when plsql-mode is started.")

(defvar plsql-load-hook nil
  "*Hook run when plsql-mode is loaded.")

(defvar plsql-mode-syntax-table nil
  "Syntax table for plsql.")

;;{{{ plsql-mode

(defun plsql-mode ()
"
plsql-mode by Yasuyuki Ulagoe
"
  (interactive)
  (kill-all-local-variables)

;  (use-local-map plsql-mode-map)
;  (setq local-abbrev-table plsql-mode-abbrev-table)
;  (set-syntax-table plsql-mode-syntax-table)

  (setq mode-name "PL/SQL")
  (setq major-mode 'plsql-mode)

  (make-local-variable 'comment-start)
  (make-local-variable 'comment-end)
  (make-local-variable 'comment-column)
;  (make-local-variable 'comment-start-skip)
;  (make-local-variable 'indent-line-function)

  (setq comment-start "/*"
	comment-end "*/"
;	comment-start-skip "<!--[ \t]*"
	comment-column "--"
;	indent-line-function 'plsql-indent
)

;  (tempo-use-tag-list 'plsql-tempo-tags plsql-completion-finder)
;  
;  (if plsql-do-write-file-hooks
;      (add-hook 'local-write-file-hooks 'plsql-update-timestamp))
;
;  (if (and plsql-build-new-buffer (zerop (buffer-size)))
;      (plsql-insert-new-buffer-strings))
;  
  (run-hooks 'plsql-mode-hook)
)

(if (fboundp 'hilit-set-mode-patterns)
    (hilit-set-mode-patterns
     'plsql-mode
     '(("'[^'\n]*'" nil darkorange-underline)
       ("[ \t][ \t]*$" nil yellow-underline)
       ("\t" nil black/lavender)
       ("   *" nil yellow-underline)
;       ("[\t]  *" nil green-underline)
       ("@" nil white/lightyellow)
       ("/\\*" "\\*/" firebrick)
       ("--.*$" nil firebrick)
       (";" nil navyblue)
       ("," nil darkgreen)
       ("[ \t]\\([Ii][Nn]\\|[Oo][Uu][Tt]\\|[Ii][Nn][ \t][Oo][Uu][Tt]\\)[ \t]" nil maroon)
;       ("[0-9A-Za-z_]*_[Dd][Aa][Tt]\\.[0-9A-Za-z_]*" nil forestgreen-underline)
       ("[0-9A-Za-z_]*_[Dd][Aa][Tt]\\.[0-9A-Za-z_]*" nil gray35)
       ("[ \t]\\([Nn][Uu][Mm][Bb][Ee][Rr]\\|[Vv][Aa][Rr][Cc][Hh][Aa][Rr]2\\|[Cc][Hh][Aa][Rr]\\|[Dd][Aa][Tt][Ee]\\)" nil darkgoldenrod)
       ("\\([Bb][Ee][Gg][Ii][Nn]\\|[Ee][Nn][Dd][ \t\n]*;\\|[Ee][Xx][Cc][Ee][Pp][Tt][Ii][Oo][Nn]\\)" nil define)
       ("[Ee][Nn][Dd][ \t\n]+[^_\t\n]+_[^;\t\n]+[ \t\n]*;" nil define)
       ("[ \t\n]\\([Aa][Nn][Dd]\\|[Oo][Rr]\\)[ \t\n]" nil magenta)
       ("\\([Pp][Rr][Oo][Cc][Ee][Dd][Uu][Rr][Ee]\\|[Ff][Uu][Nn][Cc][Tt][Ii][Oo][Nn]\\)" "[ )\n\t][Ii][Ss][ \n\t]" blue-bold)
       ("[ \t\n][Cc][Uu][Rr][Ss][Oo][Rr][ \t\n]" "[ )\n\t][Ii][Ss][ \n\t]" blue)
       ("[Ss][Qq][Ll]%[A-Za-z]*" nil violetred4)
       ("[ \t\n]\\(=\\|<\\|>\\|<=\\|>=\\|<>\\)[ \t\n]" nil seagreen4)
       ("\\([Ii][Ff][^;]\\|[Ee][Ll][Ss][Ii][Ff]\\)" "[Tt][Hh][Ee][Nn]" keyword)
       ("[Ww][Hh][Ee][Nn]" "\\([Tt][Hh][Ee][Nn]\\|;\\)" keyword)
       ("\\([Ee][Ll][Ss][Ee]\\|[Ee][Nn][Dd][ \t][Ii][Ff]\\)" nil keyword)
       ("[ \t\n;]\\([Ww][Hh][Ii][Ll][Ee]\\|[Ff][Oo][Rr]\\)[ \n\t][^;]*[ \t\n)][Ll][Oo][Oo][Pp][ \t\n]" nil forestgreen)
       ("[Ee][Nn][Dd][ \t][ \t]*[Ll][Oo][Oo][Pp]" nil forestgreen)
       ("[Ll][Oo][Oo][Pp]" nil forestgreen)
       ("[ \t\n]\\([Rr][Aa][Ii][Ss][Ee]\\|[Ee][Xx][Ii][Tt]\\)[ \t\n]" nil cadetblue)
       ("[ \t\n]\\([Ss][Ee][Ll][Ee][Cc][Tt]\\|[Ff][Rr][Oo][Mm]\\|[Ww][Hh][Ee][Rr][Ee]\\|[Hh][Aa][Vv][Ii][Nn][Gg]\\)[ \t\n]" nil include)
       ("[ \t\n]\\(\\([Gg][Rr][Oo][Uu][Pp]\\|[Oo][Rr][Dd][Ee][Rr]\\)[ \t]+[Bb][Yy]\\)[ \t\n]" nil include)
       ("[ \t\n]\\([Ii][Nn][Ss][Ee][Rr][Tt]\\|[Ii][Nn][Tt][Oo]\\)[ \t\n]" nil include)
       ("[ \t\n][Ii][Nn][Tt][Oo][ \t\n]" nil include)
       ("[ \t\n)][Vv][Aa][Ll][Uu][Ee][Ss][ \t\n)]" nil include)
       ("[ \t\n)]\\([Uu][Pp][Dd][Aa][Tt][Ee]\\|[Ss][Ee][Tt]\\)[ \t\n)]" nil include)
       ("[ \t\n)]\\([Tt][Rr][Uu][Nn][Cc][Aa][Tt][Ee]\\|[Dd][Ee][Ll][Ee][Tt][Ee]\\)[ \t\n)]" nil include)
;       ("[ \t\n)]\\([Cc][Oo][Mm][Mm][Ii][Tt]\\|[Rr][Oo][Ll][Ll][Bb][Aa][Cc][Kk]\\)[ \t\n)]" nil include)
       ("[ \t\n)]\\([Cc][Oo][Mm][Mm][Ii][Tt]\\|[Rr][Oo][Ll][Ll][Bb][Aa][Cc][Kk]\\)" nil include)
       ("[ \t\n)]\\([Oo][Pp][Ee][Nn]\\|[Cc][Ll][Oo][Ss][Ee]\\|[Ff][Ee][Tt][Cc][Hh]\\)[ \t\n)]" nil include)
;       ("[Aa]\\.[0-9A-Za-z_]*" nil indianred4)
;       ("[Bb]\\.[0-9A-Za-z_]*" nil gold4)
;       ("[Cc]\\.[0-9A-Za-z_]*" nil darkolivegreen)
;       ("[Cc]\\.[0-9A-Za-z_]*" nil darkolivegreen)
;       ("[Dd]\\.[0-9A-Za-z_]*" nil blue4)
;       ("[Ee]\\.[0-9A-Za-z_]*" nil purple4)
       ("(\\+)" nil red)
            nil 'case-insensitive)
  nil))
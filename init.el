;;; load-pathの追加関数
(defun add-to-load-path (&rest paths)
    (let (path)
        (dolist (path paths paths)
            (let ((default-directory (expand-file-name (concat user-emacs-directory path))))
                (add-to-list 'load-path default-directory)
                (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
                    (normal-top-level-add-subdirs-to-load-path))))))

;;; load-pathに追加するフォルダ
;;; 2つ以上指定する場合の形 -> (add-to-load-path "elisp" "xxx" "xxx")
(add-to-load-path "elisp")

;;; 複数ウィンドウを開かないようにする
(setq ns-pop-up-frames nil)

;;; スタートアップ非表示
(setq inhibit-startup-screen t)

;; スクラッチの初期メッセージ非表示
(setq initial-scratch-message "")

;;; ツールバー非表示
(tool-bar-mode 0)

;;; Windows で英数に DejaVu Sans Mono、日本語にMS Gothicを指定
(when (eq window-system 'w32)
    (set-face-attribute 'default nil
        :family "Fira Code"
        ;;  :family "Meiryo UI"                      
        :height 100)
    (set-fontset-font nil 'japanese-jisx0208 (font-spec :family "Meiryo UI")))

;;; *.~ とかのバックアップファイルを作らない
(setq make-backup-files nil)
;;; .#* とかのバックアップファイルを作らない
(setq auto-save-default nil)

;; EmacsでCtlr+aとCtrl+eにもっと活躍してもらう
;; http://d.hatena.ne.jp/orangeclover/20110301/1298910542
;;(require 'sequential-command-config)
;;(sequential-command-setup-keys)


;;; 行番号表示(重いから表示しない)
;;(global-linum-mode)

;;; 文字コード
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)
(setq file-name-coding-system 'sjis)
(setq locale-coding-system 'utf-8)

;;; 最近使ったファイルをメニューに表示
(recentf-mode 1)
(setq recentf-max-menu-items 10)
(setq recentf-max-saved-items 10)

;;; 履歴を次回Emacs起動時にも保存する
;; (savehist-mode 1)

;;; モードラインに時刻を表示する
;;(display-time)

;;; GCを減らして軽くする(デフォルトの10倍)
;;; 現在のマシンパワーであればもっと大きくしてもよい
(setq gc-cons-threshold (* 10 gc-cons-threshold))

;;; ログの記録行数を増やす
(setq message-log-max 10000)

;;; ミニバッファを再帰的に呼びさせるようにする
(setq enable-recursive-minibuffers t)

;;; ダイアログボックスを使わないようにする
(setq use-dialog-box nil)
(defalias 'message-box 'message)

;;; 履歴をたくさん保存する
(setq history-length 1000)

;;; キーストロークをエコーエリアに早く表示する
(setq echo-keystrokes 0.1)

;;; 大きいファイルを開こうとしたときに警告を発生させる
;;; デフォルトは10MBなので25MBに拡張する
(setq large-file-warning-threshold (* 25 1024 1024))

;;; yesと入力するのは面倒なのでyで十分
(defalias 'yes-or-no-p 'y-or-n-p)

;;; 現在位置のファイル,URLを開く
(ffap-bindings)

;;; カーソル位置を戻す
(require 'point-undo)
(define-key global-map (kbd "<f7>") 'point-undo)
(define-key global-map (kbd "S-<f7>") 'point-undo)


;;; auto-install.el
;; elispのインストール自動化
;; http://www.emacswiki.org/emacs/download/auto-install.el
(when (require 'auto-install nil t)
    (setq auto-install-directory "~/.emacs.d/elisp/")
    (auto-install-update-emacswiki-package-name t)
    (auto-install-compatibility-setup))


;; 現在行をハイライト(重いからはずす)
 (global-hl-line-mode t)
 (defface my-hl-line-face
   '((((class color) (background dark))  ; カラーかつ, 背景が dark ならば,
      (:background "gray24" t))   ; 背景を紺色に
     (((class color) (background light)) ; カラーかつ, 背景が light ならば,
      (:background "PeachPuff" t))     ; 背景を緑色 に.
     (t (:bold t)))
   "hl-line's my face")
 (setq hl-line-face 'my-hl-line-face)

;; カーソル行に下n線を表示
;; (setq hl-line-face 'underline)

;;; 括弧の範囲内を強調表示
(setq show-paren-delay 0)
(show-paren-mode t)
(setq show-paren-style 'mixed)

;; 括弧の範囲色
;;黒背景用
(set-face-background 'show-paren-match-face "dark orange")

;;; 選択領域の色
(set-face-background 'region "MediumSpringGreen")
(set-face-foreground 'region "Black")


;; TABの表示幅。初期値は8
(setq-default tab-width 2 indent-tabs-mode nil)

;; "C-t"でウィンドウを切り替える。初期値はtarnspose-chars
(define-key global-map (kbd "C-t") 'other-window)

;; anything
;; (auto-install-batch "anything")
(when (require 'anything nil t)
    (setq
        ;; 候補を表示するまでの時間。デフォルトは0.5
        anything-idle-delay 0.3
        ;; タイプして再描写するまでの時間。デフォルトは0.1
        anything-input-idle-delay 0.2
        ;; 候補の最大表示数。デフォルトは50
        anything-candidate-number-limit 100
        ;; 候補が多いときに体感速度を早くする
        anything-quick-update t
        ;; 候補選択ショートカットをアルファベットに
        anything-enable-shortcuts 'alphabet)

    (when (require 'anything-config nil t)
        ;; root権限でアクションを実行するときのコマンド
        ;; デフォルトは"su"
        (setq anything-su-or-sudo "sudo"))
  
    (require 'anything-match-plugin nil t)
    (when (and (executable-find "cmigemo")
            (require 'migemo nil t))
        (require 'anything-migemo nil t))
    (when (require 'anything-complete nil t)
        ;; lispシンボルの補完候補の再検索時間
        (anything-lisp-complete-symbol-set-timer 150))

    (require 'anything-show-completion nil t)

    (when (require 'auto-install nil t)
        (require 'anything-auto-install nil t))

    (when (require 'descbinds-anything nil t)
        ;; describe-bindingsをanythingに置き換える
        (descbinds-anything-install)))

;; M-yにanything-show-kill-ringを割り当てる
(define-key global-map (kbd "M-y") 'anything-show-kill-ring)

;; C-x bにanythingを割り当てる
(define-key global-map (kbd "\C-xb") 'anything)

;; C-x gにanything-occurを割り当てる
(define-key global-map (kbd "\C-xg") 'anything-occur)

;; color-moccurの設定
(when (require 'color-moccur nil t)
    ;; M-oにoccur-by-moccurを割り当て
    (define-key global-map (kbd "M-o") 'occur-by-moccur)
    ;; スペース区切りでAND検索
    (setq moccur-split-word t)
    ;; ディレクトリ検索のときに除外するファイル
    (add-to-list 'dmoccur-exclusion-mask "//.DS_Store")
    (add-to-list 'dmoccur-mask "^#.+#$")
    ;; Migemoを利用できる環境であればMigemoを使う
    (when (and (executable-find "cmigemo")
            (require 'migemo nil t))
        (setq moccur-use-migemo t)))

;; 改行時に自動インデント
(global-set-key "\C-m" 'newline-and-indent)

;; bufferの先頭でカーソルを戻そうとしても音をならなくする
(defun previous-line (arg)
    (interactive "p")
    (condition-case nil
        (line-move (- arg))
        (beginning-of-buffer)))

;; bufferの最後でカーソルを動かそうとしても音をならなくする
(defun next-line (arg)
    (interactive "p")
    (condition-case nil
        (line-move arg)
        (end-of-buffer)))

;; エラー音をならなくする
(setq ring-bell-function 'ignore)

;;;スクロールバーをOFF(重いから)
(scroll-bar-mode -1)

;; elscreen
(load "elscreen" "ElScreen" t)

;; タブを表示(非表示にする場合は nil を設定する)
(setq elscreen-display-tab t)

;; 自動でスクリーンを作成
(defmacro elscreen-create-automatically (ad-do-it)
    `(if (not (elscreen-one-screen-p))
        ,ad-do-it
        (elscreen-create)
        (elscreen-notify-screen-modification 'force-immediately)
        (elscreen-message "New screen is automatically created")))

(defadvice elscreen-next (around elscreen-create-automatically activate)
    (elscreen-create-automatically ad-do-it))

(defadvice elscreen-previous (around elscreen-create-automatically activate)
    (elscreen-create-automatically ad-do-it))

(defadvice elscreen-toggle (around elscreen-create-automatically activate)
    (elscreen-create-automatically ad-do-it))

;; タブ移動を簡単に
(define-key global-map (kbd "M-t") 'elscreen-next)

;; タブ新規作成
(define-key global-map (kbd "M-e") 'elscreen-create)

;; タブ削除
(define-key global-map (kbd "M-r") 'elscreen-kill)
;; elscreen-color-theme
(require 'elscreen-color-theme)

; タブの左端の×を非表示
(setq elscreen-tab-display-kill-screen nil)

;正規表現置換
(define-key global-map (kbd "\C-c\C-r") 'replace-regexp)
(define-key global-map (kbd "\C-x\C-r") 'replace-string)


;;; 全角スペースとかに色を付ける
(require 'jaspace)
(setq jaspace-alternate-jaspace-string "□")
;;(setq jaspace-alternate-eol-string "\xab\n")
(setq jaspace-highlight-tabs t)
(setq jaspace-highlight-tabs ?^)
;; (setq jaspace-mdoes '(org-mode))
(custom-set-faces
    `(jaspace-highlight-eol-face ((t :foreground "dark slate grey"))))


;; 折り返し制御 C-c tlで切り替える
(defun toggle-truncate-lines ()
    (interactive)
    (if truncate-lines
        (setq truncate-lines nil)
        (setq truncate-lines t))
    (recenter))

;; 折り返し表示ON/OFF
(global-set-key  (kbd "C-c t l") 'toggle-truncate-lines)

;;; M-kで行のコピー
(defun duplicate-line()
    (interactive)
    (move-beginning-of-line 1)
    (kill-line)
    (yank)
    (move-beginning-of-line 1)
    )
(global-set-key (kbd "M-k") 'duplicate-line)


(global-set-key (kbd "C-c a")   'align)
(global-set-key (kbd "C-S-i")   'indent-region)


;;; bm.elの設定
;;; (install-elisp "http://cvs.savannah.gnu.org/viewvc/*checkout*/bm/bm/bm.el")
(require 'bm)
;; キーの設定
(global-set-key (kbd "M-@") 'bm-toggle)
(global-set-key (kbd "M-[") 'bm-previous)
(global-set-key (kbd "M-]") 'bm-next)
(set-face-background 'bm-face "IndianRed1")

;;; リージョンを削除できるように
(delete-selection-mode t)

;; TABキーでタブ文字を入力
(setq c-tab-always-indent nil)


;; 検索ミニバッファで大文字小文字を区別しない
(setq read-buffer-completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)


;; forward-word で単語の先頭へ移動する
(defun forward-word+1 ()
    (interactive)
    (forward-word)
    (forward-char))
(global-set-key (kbd "M-f") 'forward-word+1)

;;kill-word の後のポイントが単語の先頭になるようにする
(defun kill-word+1 ()

    (interactive)
    (kill-word 1)
    (delete-char 1))

(global-set-key (kbd "M-d") 'kill-word+1)


;; カラーテーマを設定
;; (color-theme-molokai)
;; color-theme-tangotangoを少し改造
(require 'color-theme)
(setq color-theme-load-all-themes nil)
(require 'color-theme-tangotango)
;; select theme - first list element is for windowing system, second is for console/terminal
;; Source : http://www.emacswiki.org/emacs/ColorTheme#toc9
(setq color-theme-choices 
    '(color-theme-tangotango color-theme-tangotango))

;; default-start
(funcall (lambda (cols)
    	(let ((color-theme-is-global nil))
    	    (eval 
    	        (append '(if (window-system))
    		        (mapcar (lambda (x) (cons x nil)) 
    			        cols)))))
    color-theme-choices)

;; test for each additional frame or console
(require 'cl)
(fset 'test-win-sys 
    (funcall (lambda (cols)
    		(lexical-let ((cols cols))
    		    (lambda (frame)
    		        (let ((color-theme-is-global nil))
		                ;; must be current for local ctheme
		                (select-frame frame)
		                ;; test winsystem
		                (eval 
			                (append '(if (window-system frame)) 
				                (mapcar (lambda (x) (cons x nil)) 
					                cols)))))))
    	color-theme-choices ))
;; hook on after-make-frame-functions
(add-hook 'after-make-frame-functions 'test-win-sys)
(color-theme-tangotango)


;; 指定した単語をハイライト
;; M-#でポイント位置の単語をハイライト、M-$でハイライト解除
(defun my-keep-highlight-regexp (re)
    (interactive "sRegexp: \n")
    (my-keep-highlight-set-font-lock re))

(defun my-keep-highlight-symbole-at-point ()
    (interactive)
    (my-keep-highlight-set-font-lock (or (thing-at-point 'symbol) "")))

(defun my-keep-highlight-set-font-lock (re)
    (make-face 'my-highlight-face)
    (set-face-foreground 'my-highlight-face "black")
    (set-face-background 'my-highlight-face "yellow")
    (defvar my-highlight-face 'my-highlight-face)
    (setq font-lock-set-defaults nil)
    (font-lock-set-defaults)
    (font-lock-add-keywords 'nil (list (list re 0 my-highlight-face t)))
    (font-lock-fontify-buffer))

(defun my-cancel-highlight-regexp ()
    (interactive)
    (setq font-lock-set-defaults nil)
    (font-lock-set-defaults)
    (font-lock-fontify-buffer))

(fset 'hl 'my-keep-highlight-regexp)
(global-set-key (kbd "M-#") 'my-keep-highlight-symbole-at-point)
(global-set-key (kbd "M-$") 'my-cancel-highlight-regexp)


;; Heading to the beginning of word before incsearch
;; isearch-forward-with-headingで"isfh"
;; C-s C-wでカーソル位置の単語を一括検索する
(defconst isfh-symbol-regexp "[A-Za-z_][A-Za-z_0-9]*"
    "Regexp matching word chars.")
(defconst isfh-symbol-chars "[0-9A-Za-z_]"
    "Regexp matching word char.")
(defun isfh-match-string (n)
    (buffer-substring (match-beginning n) (match-end n)))

(defun isfh-get-current-token ()
    (cond
        ((looking-at isfh-symbol-chars)
            (while (looking-at isfh-symbol-chars)
                (forward-char -1))
            (forward-char 1))
        (t
            (while (looking-at "[ \t]")
                (forward-char 1))))
    (if (looking-at isfh-symbol-regexp)
        (isfh-match-string 0) nil))

(defun isearch-forward-with-heading ()
    "Search the word your cursor looking at."
    (interactive)
    (isfh-get-current-token)
    (command-execute 'isearch-forward))

(global-set-key "\C-s" 'isearch-forward-with-heading)



;; mark-multiple
(require 'inline-string-rectangle)
(global-set-key (kbd "C-x r t") 'inline-string-rectangle)

(require 'mark-more-like-this)
(global-set-key (kbd "C-<") 'mark-previous-like-this)
(global-set-key (kbd "C->") 'mark-next-like-this)
;; (global-set-key (kbd "C-M-m") 'mark-more-like-this) ; like the other two, but takes an argument (negative is previous)
(global-set-key (kbd "C-*") 'mark-all-like-this)


;; expand region
(require 'expand-region)
(global-set-key (kbd "C-@") 'er/expand-region)
(global-set-key (kbd "C-M-@") 'er/contract-region) ;; リージョンを狭める

;; transient-mark-modeが nilでは動作しませんので注意
(transient-mark-mode t)

;; 5行単位での移動
(global-set-key "\M-n"(kbd "C-u 5 C-n"))
(global-set-key "\M-p"(kbd "C-u 5 C-p"))




(require 'undohist)

;;;; tree-undo
(when (require 'undo-tree nil t)
    (global-undo-tree-mode))

;; 画面を３分割する
;; http://d.hatena.ne.jp/yascentur/20110621/1308585547
(defun split-window-three-n (num_wins)
    (interactive "p")
    (split-window-horizontally)
    (split-window-vertically)
    )

(global-set-key "\C-x@" '(lambda ()
        (interactive)
        (split-window-three-n 3)))

;; 時間挿入
(defun my-get-date-gen (form) (insert (format-time-string form)))
(defun my-get-date() (interactive) (my-get-date-gen "%Y/%m/%d"))

;; C-cC-dで時間挿入できるようにする
(global-set-key "\C-c\C-d" 'my-get-date)

;; 選択した文字列を前後に文字を挿入する（自作関数）
(defun wrap-region-by-string ()
    (interactive
        (let ((start-point (region-beginning))
                (end-point (region-end))
                (start-str (read-string "Start: " nil 'my-history))
                (end-str (read-string "End: " nil 'my-history)))
            (save-restriction
                (save-excursion
                    (goto-char start-point)
                    (narrow-to-region start-point end-point)
                    (while (not (eobp))
                        (move-beginning-of-line 1)
                        (insert start-str)
                        (move-end-of-line 1)
                        (insert end-str)
                        (forward-line 1)
                        )
                    )))))
(global-set-key (kbd "\C-c w i") 'wrap-region-by-string)


;; 関数一覧
(global-set-key "\C-c\C-f" 'anything-imenu)

;;; 現在の関数名をモードラインに表示
(which-function-mode 1)

;; yasnippet
(add-to-list 'load-path
    (expand-file-name "~/.emacs.d/elpa/yasnippet-0.8.0"))
(require 'yasnippet)
 
(setq yas-snippet-dirs
    '("~/.emacs.d/elpa/yasnippet-0.8.0/snippets"
        ))
(yas-global-mode 1)

;; 既存スニペットを挿入
(define-key yas-minor-mode-map (kbd "C-x y i") 'yas-insert-snippet)
;; 新規スニペットを作成するバッファを用意する
(define-key yas-minor-mode-map (kbd "C-x y n") 'yas-new-snippet)
;; 既存スニペットの閲覧、編集
(define-key yas-minor-mode-map (kbd "C-x y v") 'yas-visit-snippet-file)

;; yasnippetをanythingインタフェースで選択する
(defun my-yas/prompt (prompt choices &optional display-fn)
    (let* ((names (loop for choice in choices
                    collect (or (and display-fn (funcall display-fn choice))
                        coice)))
            (selected (anything-other-buffer
                    `(((name . ,(format "%s" prompt))
                            (candidates . names)
                            (action . (("Insert snippet" . (lambda (arg) arg))))))
                    "*anything yas/prompt*")))
        (if selected
            (let ((n (position selected names :test 'equal)))
                (nth n choices))
            (signal 'quit "user quit!"))))
(custom-set-variables '(yas/prompt-functions '(my-yas/prompt)))


;; anything interface
(eval-after-load "anything-config"
    '(progn
        (defun my-yas/prompt (prompt choices &optional display-fn)
            (let* ((names (loop for choice in choices
                            collect (or (and display-fn (funcall display-fn choice))
                                choice)))
                    (selected (anything-other-buffer
                            `(((name . ,(format "%s" prompt))
                                    (candidates . names)
                                    (action . (("Insert snippet" . (lambda (arg) arg))))))
                            "*anything yas/prompt*")))
                (if selected
                    (let ((n (position selected names :test 'equal)))
                        (nth n choices))
                    (signal 'quit "user quit!"))))
        (custom-set-variables '(yas/prompt-functions '(my-yas/prompt)))
        (define-key anything-command-map (kbd "y") 'yas/insert-snippet)))


;; 起動時に最大化
(set-frame-parameter nil 'fullscreen 'maximized)


;; popwin
(setq pop-up-windows nil)
(require 'popwin nil t)
(when (require 'popwin nil t)
    (setq anything-samewindow nil)
    (setq display-buffer-function 'popwin:display-buffer)
    (push '("anything" :regexp t :height 0.5) popwin:special-display-config)
    (push '("*Completions*" :height 0.4) popwin:special-display-config)
    (push '("*compilation*" :height 0.4 :noselect t :stick t) popwin:special-display-config)
    )

;; grepでもpopwinが動くようにする
(push '("*grep*" :noselect t) popwin:special-display-config)

;; quickrun.el
;; https://github.com/syohex/emacs-quickrun
(require 'quickrun)
(push '("*quickrun*") popwin:special-display-config)

(defun my-quickrun-output-fix ()
    (interactive)
    (quickrun)
    (sit-for 0.5)
    (beginning-of-buffer)
    (sit-for 0.5)
    (end-of-buffer)
    )

(global-set-key (kbd "C-\\") 'my-quickrun-output-fix)

;; quickrunの文字化け対策
(add-hook 'java-mode-hook (lambda ()
        (setq quickrun-option-cmdopt "-J-Dfile.encoding=UTF-8")))


;; 括弧の自動挿入
(add-to-list 'load-path "/path/to/autopair") ;; comment if autopair.el is in standard load path 
(require 'autopair)
(autopair-global-mode) ;; enable autopair in all buffers


;; auto-complete
(add-to-list 'load-path "~/.emacs.d/elisp/auto-complete-1.3.1")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/elisp/auto-complete-1.3.1/ac-dict")
(ac-config-default)
(setq ac-use-menu-map t)
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)
(setq ac-menu-height 10)
;; 3文字以上の入力で起動
(setq ac-auto-start 3)
;; 0.8秒でメニュー表示
(setq ac-auto-show-menu 0.8)
;; 補完候補をソート
(setq ac-use-comphist t)
;; returnでの補完禁止
(define-key ac-completing-map (kbd "RET") nil)

;; javaの自動補完
(add-to-list 'load-path "~/.emacs.d/elisp/auto-java-complete")
(require 'ajc-java-complete-config)
(add-hook 'java-mode-hook 'ajc-java-complete-mode)
(add-hook 'find-file-hook 'ajc-4-jsp-find-file-hook)

;; 自動補完ON/OFF
(global-set-key "\C-c\C-a" 'auto-complete-mode)
;; デフォルトでAuto CompleteをONにする
(auto-complete-mode t)
;; Anything auto-completeもONにする
;; (ac-mode 1)

;; sql-modeでauto completeをオンにする
(add-to-list 'ac-modes 'sql-mode)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; C-hをbackspaceとして利用する
(global-set-key "\C-h" 'delete-backward-char)


;; Eshell
;; 補完時に大文字小文字を区別しない
(setq eshell-cmpl-ignore-case t)
;; 確認なしでヒストリ保存
(setq eshell-ask-to-save-history (quote always))
;; 補完時にサイクルする
;(setq eshell-cmpl-cycle-completions t)
(setq eshell-cmpl-cycle-completions nil)
;;補完候補がこの数値以下だとサイクルせずに候補表示
;(setq eshell-cmpl-cycle-cutoff-length 5)
;; 履歴で重複を無視する
(setq eshell-hist-ignoredups t)
;; prompt 文字列の変更
(setq eshell-prompt-function
    (lambda ()
        (concat "["
            (eshell/pwd)
            (if (= (user-uid) 0) "]\n# " "]\n$ ")
            )))
;; 変更した prompt 文字列に合う形で prompt の初まりを指定 (C-a で"$ "の次にカーソルがくるようにする)
;; これの設定を上手くしとかないとタブ補完も効かなくなるっぽい
(setq eshell-prompt-regexp "^[^#$]*[$#] ")
;; キーバインドの変更
(add-hook 'eshell-mode-hook
    '(lambda ()
        (progn
            (define-key eshell-mode-map "\C-a" 'eshell-bol)

            (define-key eshell-mode-map [up] 'previous-line)
            (define-key eshell-mode-map [down] 'next-line)
            (define-key eshell-mode-map [(meta return)] (select-toggle-fullscreen))
            )
        ))

;; エスケープシーケンスを処理
;; http://d.hatena.ne.jp/hiboma/20061031/1162277851
(autoload 'ansi-color-for-comint-mode-on "ansi-color"
    "Set `ansi-color-for-comint-mode' to t." t)
(add-hook 'eshell-load-hook 'ansi-color-for-comint-mode-on)
;; http://www.emacswiki.org/emacs-ja/EshellColor
(require 'ansi-color)
(require 'eshell)
(defun eshell-handle-ansi-color ()
    (ansi-color-apply-on-region eshell-last-output-start
        eshell-last-output-end))
(add-to-list 'eshell-output-filter-functions 'eshell-handle-ansi-color)
(put 'erase-buffer 'disabled nil)

;; eshellでclearコマンドを実現する
(defun eshell-clear ()
    "Hi, you will clear the eshell buffer."
    (interactive)
    (let ((inhibit-read-only t))
        (erase-buffer)
        (message "erase eshell buffer")))

(defun my-shell-hook ()
    (local-set-key "\C-cl" 'eshell-clear))
(add-hook 'eshell-mode-hook 'my-shell-hook)

;; 許されざるText is read-onlyを回避する
(defadvice eshell-get-old-input (after eshell-read-only-korosu activate)
    (setq ad-return-value (substring-no-properties ad-return-value)))

;; eshell文字化け対策
(add-hook 'set-language-environment-hook 
    (lambda ()
        (when (equal "ja_JP.UTF-8" (getenv "LANG"))
            (setq default-process-coding-system '(utf-8 . utf-8))
            (setq default-file-name-coding-system 'utf-8))
        (when (equal "Japanese" current-language-environment)
            (setq default-buffer-file-coding-system 'iso-2022-jp))))

(set-language-environment "Japanese")

(defun my-make-scratch (&optional arg)
    (interactive)
    (progn
        ;; "*scratch*" を作成して buffer-list に放り込む
        (set-buffer (get-buffer-create "*scratch*"))
        (funcall initial-major-mode)  
        (erase-buffer)  
        (when (and initial-scratch-message (not inhibit-startup-message))  
            (insert initial-scratch-message))  
        (or arg (progn (setq arg 0)  
                (switch-to-buffer "*scratch*")))  
        (cond ((= arg 0) (message "*scratch* is cleared up."))  
            ((= arg 1) (message "another *scratch* is created")))))

(add-hook 'kill-buffer-query-functions  
    ;; *scratch* バッファで kill-buffer したら内容を消去するだけにする  
    (lambda ()  
        (if (string= "*scratch*" (buffer-name))
            (progn (my-make-scratch 0) nil)
            t)))
 
(add-hook 'after-save-hook  
    ;; *scratch* バッファの内容を保存したら *scratch* バッファを新しく作る  
    (lambda ()  
        (unless (member (get-buffer "*scratch*") (buffer-list))
            (my-make-scratch 1))))


;; SQL関連の設定
(autoload 'sql-mode "sql" "SQL Edit mode" t)
(autoload 'sql-oracle "sql" "SQL Edit mode" t)
(autoload 'sql-ms "sql" "SQL Edit mode" t)
(autoload 'master-mode "master" "Master mode minor mode." t)

;; SQL mode に入った時点で sql-indent / sql-complete を読み込む
(eval-after-load "sql"
    '(progn
        (load-library "sql-indent")
        (load-library "sql-complete")
        (load-library "sql-transform")
        ))


;; SQL モードの雑多な設定
(add-hook 'sql-mode-hook
    (function (lambda ()
            (setq sql-indent-offset 4)
            (setq sql-indent-maybe-tab t)
            (local-set-key "\C-cu" 'sql-to-update) ; sql-transform 
            ;; SQLi の自動ポップアップ
            (setq sql-pop-to-buffer-after-send-region t)xbs
            ;; master モードを有効にし、SQLi をスレーブバッファにする
            (master-mode t)
            (master-set-slave sql-buffer)
            ))
    )


;; (require 'magit)

;; WindowsでEmacsを１つだけ起動して実行する
;; (ファイルの関連付けは~/emacs/bin/emacsclientw.exeで行う)
(server-start)

;; XML整形
(defun xml-format ()
    (interactive
        (save-restriction
            (save-excursion
                (sgml-mode)
                (sgml-pretty-print (region-beginning) (region-end))
                (xml-mode)
                ))))
(add-hook 'xml-mode-hook 'xml-format)

;; ログは読み取り専用モードで開く
(add-to-list 'auto-mode-alist '("\\.log$" . read-only-mode))


;; 巨大ファイルを開くときの関数
(defun liteweight-on()
  "to read large file."
  (interactive)
  (progn
    (auto-complete-mode nil)
    (ac-mode -1)
    (autopair-global-mode -1)
    (yas-minor-mode -1)
    (global-undo-tree-mode -1)))

(defun liteweight-off()
  (interactive)
  (progn
    (auto-complete-mode t)
    (ac-mode 1)
    (autopair-global-mode 1)
    (yas-minor-mode 1)
    (global-undo-tree-mode 1)))

;; 物理行単位で移動する
(setq line-move-visual nil)

(package-initialize)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)

(require 'dired-subtree)
;;; iを置き換え
(define-key dired-mode-map (kbd "i") 'dired-subtree-insert)
;;; org-modeのようにTABで折り畳む
(define-key dired-mode-map (kbd "<tab>") 'dired-subtree-remove)
;;; C-x n nでsubtreeにナローイング
(define-key dired-mode-map (kbd "C-x n n") 'dired-subtree-narrow)

;;; ファイル名以外の情報を(と)で隠したり表示したり
(require 'dired-details)
(dired-details-install)
(setq dired-details-hidden-string "")
(setq dired-details-hide-link-targets nil)
(setq dired-details-initially-hide nil)

;;; dired-subtreeをdired-detailsに対応させる
(defun dired-subtree-after-insert-hook--dired-details ()
  (dired-details-delete-overlays)
  (dired-details-activate))
(add-hook 'dired-subtree-after-insert-hook
          'dired-subtree-after-insert-hook--dired-details)

;; find-dired対応
(defadvice find-dired-sentinel (after dired-details (proc state) activate)
  (ignore-errors
    (with-current-buffer (process-buffer proc)
      (dired-details-activate))))
;; (progn (ad-disable-advice 'find-dired-sentinel 'after 'dired-details) (ad-update 'find-dired-sentinel))

;;; [2014-12-30 Tue]^をdired-subtreeに対応させる
(defun dired-subtree-up-dwim (&optional arg)
  "subtreeの親ディレクトリに移動。そうでなければ親ディレクトリを開く(^の挙動)。"
  (interactive "p")
  (or (dired-subtree-up arg)
      (dired-up-directory)))
(define-key dired-mode-map (kbd "^") 'dired-subtree-up-dwim)

(define-key global-map (kbd "M-x") 'anything-M-x)

;; yasnippetとauto-completeの競合を解消
(setq ac-source-yasnippet nil)


;; https://github.com/purcell/elisp-slime-nav
;; M-. ポイント位置のシンボル（関数・変数）の定義元にジャンプ
;; M-, ジャンプ前の位置に戻る
;; C-c C-d d (C-c C-d C-d) シンボルのヘルプを参照する
(require 'elisp-slime-nav)
(dolist (hook '(emacs-lisp-mode-hook ielm-mode-hook))
  (add-hook hook 'elisp-slime-nav-mode))

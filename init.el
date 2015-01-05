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

;;; ファイルのフルパスをタイトルバーに表示
(setq frame-title-format
      (format "%%f - Emacs@%s" (system-name)))

;;; Windows で英数に DejaVu Sans Mono、日本語にMS Gothicを指定
(when (eq window-system 'w32)
  (set-face-attribute 'default nil
                    ;;  :family "DejaVu Sans Mono"
                    ;;  :family "MeiryoKe_Gothic" 
                         :family "Consolas"
                    ;;  :family "Meiryo UI"                      
                      :height 100)
  (set-fontset-font nil 'japanese-jisx0208 (font-spec :family "Meiryo UI")))

;;; バックアップを残さない
(setq make-backup-files nil)

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

;;; migemo
(cond
 ((eq system-type 'darwin)
  ;; Mac(Cocoa Emacs)
  (require 'migemo)
  (setq migemo-command "/usr/local/bin/cmigemo")
  (setq migemo-options '("-q" "--emacs"))
  (setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
  (setq migemo-user-dictionary nil)
  (setq migemo-coding-system 'utf-8-unix)
  (setq migemo-regex-dictionary nil)
  (load-library "migemo")
  (migemo-init)
  )
 ((eq system-type 'windows-nt)
  ;; Windows
  )
 )

(cond((eq system-type 'darwin)
  ;; emacs 起動時は英数モードから始める
  (add-hook 'after-init-hook 'mac-change-language-to-us)
  ;; minibuffer 内は英数モードにする
  (add-hook 'minibuffer-setup-hook 'mac-change-language-to-us)
  ;; [migemo]isearch のとき IME を英数モードにする
  (add-hook 'isearch-mode-hook 'mac-change-language-to-us)
  )
)

;;; auto-install.el
;; elispのインストール自動化
;; http://www.emacswiki.org/emacs/download/auto-install.el
  (when (require 'auto-install nil t)
    (setq auto-install-directory "~/.emacs.d/elisp/")
    (auto-install-update-emacswiki-package-name t)
    (auto-install-compatibility-setup))


;; 現在行をハイライト
(global-hl-line-mode t)
(defface my-hl-line-face
  '((((class color) (background dark))  ; カラーかつ, 背景が dark ならば,
     (:background "gray24" t))   ; 背景を紺色に
    (((class color) (background light)) ; カラーかつ, 背景が light ならば,
     (:background "PeachPuff" t))     ; 背景を緑色 に.
    (t (:bold t)))
  "hl-line's my face")
(setq hl-line-face 'my-hl-line-face)

;; カーソル行に下線を表示
;;(setq hl-line-face 'underline)

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
(setq-default tab-width 4 indent-tabs-mode nil)

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

;; C-x bにanything-for-filesを割り当てる
(define-key global-map (kbd "\C-xb") 'anything-for-files)

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


;; 折り返し制御 C-c C-lで切り替える
(defun toggle-truncate-lines ()
  (interactive)
  (if truncate-lines
      (setq truncate-lines nil)
    (setq truncate-lines t))
  (recenter))

;; 折り返し表示ON/OFF
(global-set-key "\C-c\C-l" 'toggle-truncate-lines)  

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

;;; リージョンを削除できるように
(delete-selection-mode t)

;; TABキーでタブ文字を入力
(setq c-tab-always-indent nil)


;; 検索ミニバッファで大文字小文字を区別しない
(setq read-buffer-completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)


; "forward-word で単語の先頭へ移動する"
(defun forward-word+1 ()
  (interactive)
  (forward-word)
  (forward-char))

(global-set-key (kbd "M-f") 'forward-word+1)
(global-set-key (kbd "C-M-f") 'forward-word+1)

;;kill-word の後のポイントが単語の先頭になるようにする
(defun kill-word+1 ()

  (interactive)
  (kill-word 1)
  (delete-char 1))

(global-set-key (kbd "M-d") 'kill-word+1)
(global-set-key (kbd "C-M-d") 'kill-word+1)


;; カラーテーマを設定
(require 'color-theme)
(color-theme-initialize)
(color-theme-molokai)


;; カーソル行の単語コピー
(defun kill-ring-save-current-word ()
"Save current word to kill ring as if killed, but don't kill it."
(interactive)
(kill-new (current-word)))
(global-set-key "\C-xw" 'kill-ring-save-current-word)


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


;; EmacsでCtlr+aとCtrl+eにもっと活躍してもらう
;; http://d.hatena.ne.jp/orangeclover/20110301/1298910542
(require 'sequential-command-config)
(sequential-command-setup-keys)


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
 (global-set-key (kbd "\C-c\C-w") 'wrap-region-by-string)



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

;; popwin-el
;; https://github.com/m2ym/popwin-el
(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)

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

;; javaの自動補完
(add-to-list 'load-path "~/.emacs.d/elisp/auto-java-complete")
(require 'ajc-java-complete-config)
(add-hook 'java-mode-hook 'ajc-java-complete-mode)
(add-hook 'find-file-hook 'ajc-4-jsp-find-file-hook)

;; 自動補完ON/OFF
(global-set-key "\C-c\C-a" 'auto-complete-mode)

;; sql-modeでauto completeをオンにする
(add-to-list 'ac-modes 'sql-mode)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; C-hをbackspaceとして利用する
(global-set-key "\C-h" 'delete-backward-char)

;;; load-path�̒ǉ��֐�
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))

;;; load-path�ɒǉ�����t�H���_
;;; 2�ȏ�w�肷��ꍇ�̌` -> (add-to-load-path "elisp" "xxx" "xxx")
(add-to-load-path "elisp")

;;; �����E�B���h�E���J���Ȃ��悤�ɂ���
(setq ns-pop-up-frames nil)

;;; �X�^�[�g�A�b�v��\��
(setq inhibit-startup-screen t)

;; �X�N���b�`�̏������b�Z�[�W��\��
(setq initial-scratch-message "")

;;; �c�[���o�[��\��
(tool-bar-mode 0)

;;; �t�@�C���̃t���p�X���^�C�g���o�[�ɕ\��
(setq frame-title-format
      (format "%%f - Emacs@%s" (system-name)))

;;; Windows �ŉp���� DejaVu Sans Mono�A���{���MS Gothic���w��
(when (eq window-system 'w32)
  (set-face-attribute 'default nil
                    ;;  :family "DejaVu Sans Mono"
                    ;;  :family "MeiryoKe_Gothic" 
                         :family "Consolas"
                    ;;  :family "Meiryo UI"                      
                      :height 100)
  (set-fontset-font nil 'japanese-jisx0208 (font-spec :family "Meiryo UI")))

;;; �o�b�N�A�b�v���c���Ȃ�
(setq make-backup-files nil)

;;; �s�ԍ��\��(�d������\�����Ȃ�)
;;(global-linum-mode)

;;; �����R�[�h
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)
(setq file-name-coding-system 'sjis)
(setq locale-coding-system 'utf-8)

;;; �ŋߎg�����t�@�C�������j���[�ɕ\��
(recentf-mode 1)
(setq recentf-max-menu-items 10)
(setq recentf-max-saved-items 10)

;;; ����������Emacs�N�����ɂ��ۑ�����
;; (savehist-mode 1)

;;; ���[�h���C���Ɏ�����\������
;;(display-time)

;;; GC�����炵�Čy������(�f�t�H���g��10�{)
;;; ���݂̃}�V���p���[�ł���΂����Ƒ傫�����Ă��悢
(setq gc-cons-threshold (* 10 gc-cons-threshold))

;;; ���O�̋L�^�s���𑝂₷
(setq message-log-max 10000)

;;; �~�j�o�b�t�@���ċA�I�ɌĂт�����悤�ɂ���
(setq enable-recursive-minibuffers t)

;;; �_�C�A���O�{�b�N�X���g��Ȃ��悤�ɂ���
(setq use-dialog-box nil)
(defalias 'message-box 'message)

;;; ��������������ۑ�����
(setq history-length 1000)

;;; �L�[�X�g���[�N���G�R�[�G���A�ɑ����\������
(setq echo-keystrokes 0.1)

;;; �傫���t�@�C�����J�����Ƃ����Ƃ��Ɍx���𔭐�������
;;; �f�t�H���g��10MB�Ȃ̂�25MB�Ɋg������
(setq large-file-warning-threshold (* 25 1024 1024))

;;; yes�Ɠ��͂���͖̂ʓ|�Ȃ̂�y�ŏ\��
(defalias 'yes-or-no-p 'y-or-n-p)

;;; ���݈ʒu�̃t�@�C��,URL���J��
(ffap-bindings)

;;; �J�[�\���ʒu��߂�
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
  ;; emacs �N�����͉p�����[�h����n�߂�
  (add-hook 'after-init-hook 'mac-change-language-to-us)
  ;; minibuffer ���͉p�����[�h�ɂ���
  (add-hook 'minibuffer-setup-hook 'mac-change-language-to-us)
  ;; [migemo]isearch �̂Ƃ� IME ���p�����[�h�ɂ���
  (add-hook 'isearch-mode-hook 'mac-change-language-to-us)
  )
)

;;; auto-install.el
;; elisp�̃C���X�g�[��������
;; http://www.emacswiki.org/emacs/download/auto-install.el
  (when (require 'auto-install nil t)
    (setq auto-install-directory "~/.emacs.d/elisp/")
    (auto-install-update-emacswiki-package-name t)
    (auto-install-compatibility-setup))


;; ���ݍs���n�C���C�g
(global-hl-line-mode t)
(defface my-hl-line-face
  '((((class color) (background dark))  ; �J���[����, �w�i�� dark �Ȃ��,
     (:background "gray24" t))   ; �w�i�����F��
    (((class color) (background light)) ; �J���[����, �w�i�� light �Ȃ��,
     (:background "PeachPuff" t))     ; �w�i��ΐF ��.
    (t (:bold t)))
  "hl-line's my face")
(setq hl-line-face 'my-hl-line-face)

;; �J�[�\���s�ɉ�����\��
;;(setq hl-line-face 'underline)

;;; ���ʂ͈͓̔��������\��
(setq show-paren-delay 0)
(show-paren-mode t)
(setq show-paren-style 'mixed)

;; ���ʂ͈̔͐F
;;���w�i�p
(set-face-background 'show-paren-match-face "dark orange")

;;; �I��̈�̐F
(set-face-background 'region "MediumSpringGreen")
(set-face-foreground 'region "Black")


;; TAB�̕\�����B�����l��8
(setq-default tab-width 4 indent-tabs-mode nil)

;; "C-t"�ŃE�B���h�E��؂�ւ���B�����l��tarnspose-chars
(define-key global-map (kbd "C-t") 'other-window)

;; anything
;; (auto-install-batch "anything")
(when (require 'anything nil t)
  (setq
   ;; ����\������܂ł̎��ԁB�f�t�H���g��0.5
   anything-idle-delay 0.3
   ;; �^�C�v���čĕ`�ʂ���܂ł̎��ԁB�f�t�H���g��0.1
   anything-input-idle-delay 0.2
   ;; ���̍ő�\�����B�f�t�H���g��50
   anything-candidate-number-limit 100
   ;; ��₪�����Ƃ��ɑ̊����x�𑁂�����
   anything-quick-update t
   ;; ���I���V���[�g�J�b�g���A���t�@�x�b�g��
   anything-enable-shortcuts 'alphabet)

  (when (require 'anything-config nil t)
    ;; root�����ŃA�N�V���������s����Ƃ��̃R�}���h
    ;; �f�t�H���g��"su"
    (setq anything-su-or-sudo "sudo"))
  
  (require 'anything-match-plugin nil t)
  (when (and (executable-find "cmigemo")
             (require 'migemo nil t))
    (require 'anything-migemo nil t))
  (when (require 'anything-complete nil t)
    ;; lisp�V���{���̕⊮���̍Č�������
    (anything-lisp-complete-symbol-set-timer 150))

  (require 'anything-show-completion nil t)

  (when (require 'auto-install nil t)
    (require 'anything-auto-install nil t))

  (when (require 'descbinds-anything nil t)
    ;; describe-bindings��anything�ɒu��������
    (descbinds-anything-install)))

;; M-y��anything-show-kill-ring�����蓖�Ă�
(define-key global-map (kbd "M-y") 'anything-show-kill-ring)

;; C-x b��anything-for-files�����蓖�Ă�
(define-key global-map (kbd "\C-xb") 'anything-for-files)

;; C-x g��anything-occur�����蓖�Ă�
(define-key global-map (kbd "\C-xg") 'anything-occur)

;; color-moccur�̐ݒ�
(when (require 'color-moccur nil t)
  ;; M-o��occur-by-moccur�����蓖��
  (define-key global-map (kbd "M-o") 'occur-by-moccur)
  ;; �X�y�[�X��؂��AND����
  (setq moccur-split-word t)
  ;; �f�B���N�g�������̂Ƃ��ɏ��O����t�@�C��
  (add-to-list 'dmoccur-exclusion-mask "//.DS_Store")
  (add-to-list 'dmoccur-mask "^#.+#$")
  ;; Migemo�𗘗p�ł�����ł����Migemo���g��
  (when (and (executable-find "cmigemo")
             (require 'migemo nil t))
    (setq moccur-use-migemo t)))

;; ���s���Ɏ����C���f���g
(global-set-key "\C-m" 'newline-and-indent)

;; buffer�̐擪�ŃJ�[�\����߂����Ƃ��Ă������Ȃ�Ȃ�����
(defun previous-line (arg)
  (interactive "p")
  (condition-case nil
      (line-move (- arg))
    (beginning-of-buffer)))

;; buffer�̍Ō�ŃJ�[�\���𓮂������Ƃ��Ă������Ȃ�Ȃ�����
(defun next-line (arg)
  (interactive "p")
  (condition-case nil
      (line-move arg)
    (end-of-buffer)))

;; �G���[�����Ȃ�Ȃ�����
(setq ring-bell-function 'ignore)

;;;�X�N���[���o�[��OFF(�d������)
(scroll-bar-mode -1)

;; elscreen
(load "elscreen" "ElScreen" t)

;; �^�u��\��(��\���ɂ���ꍇ�� nil ��ݒ肷��)
(setq elscreen-display-tab t)

;; �����ŃX�N���[�����쐬
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

;; �^�u�ړ����ȒP��
(define-key global-map (kbd "M-t") 'elscreen-next)

;; �^�u�V�K�쐬
(define-key global-map (kbd "M-e") 'elscreen-create)

;; �^�u�폜
(define-key global-map (kbd "M-r") 'elscreen-kill)
;; elscreen-color-theme
(require 'elscreen-color-theme)

; �^�u�̍��[�́~���\��
(setq elscreen-tab-display-kill-screen nil)

;���K�\���u��
(define-key global-map (kbd "\C-c\C-r") 'replace-regexp)
(define-key global-map (kbd "\C-x\C-r") 'replace-string)



;;; �S�p�X�y�[�X�Ƃ��ɐF��t����
(require 'jaspace)
(setq jaspace-alternate-jaspace-string "��")
;;(setq jaspace-alternate-eol-string "\xab\n")
(setq jaspace-highlight-tabs t)
(setq jaspace-highlight-tabs ?^)
;; (setq jaspace-mdoes '(org-mode))
(custom-set-faces
 `(jaspace-highlight-eol-face ((t :foreground "dark slate grey"))))


;; �܂�Ԃ����� C-c C-l�Ő؂�ւ���
(defun toggle-truncate-lines ()
  (interactive)
  (if truncate-lines
      (setq truncate-lines nil)
    (setq truncate-lines t))
  (recenter))

;; �܂�Ԃ��\��ON/OFF
(global-set-key "\C-c\C-l" 'toggle-truncate-lines)  

;;; M-k�ōs�̃R�s�[
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


;;; bm.el�̐ݒ�
;;; (install-elisp "http://cvs.savannah.gnu.org/viewvc/*checkout*/bm/bm/bm.el")
(require 'bm)
;; �L�[�̐ݒ�
(global-set-key (kbd "M-@") 'bm-toggle)
(global-set-key (kbd "M-[") 'bm-previous)
(global-set-key (kbd "M-]") 'bm-next)

;;; ���[�W�������폜�ł���悤��
(delete-selection-mode t)

;; TAB�L�[�Ń^�u���������
(setq c-tab-always-indent nil)


;; �����~�j�o�b�t�@�ő啶������������ʂ��Ȃ�
(setq read-buffer-completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)


; "forward-word �ŒP��̐擪�ֈړ�����"
(defun forward-word+1 ()
  (interactive)
  (forward-word)
  (forward-char))

(global-set-key (kbd "M-f") 'forward-word+1)
(global-set-key (kbd "C-M-f") 'forward-word+1)

;;kill-word �̌�̃|�C���g���P��̐擪�ɂȂ�悤�ɂ���
(defun kill-word+1 ()

  (interactive)
  (kill-word 1)
  (delete-char 1))

(global-set-key (kbd "M-d") 'kill-word+1)
(global-set-key (kbd "C-M-d") 'kill-word+1)


;; �J���[�e�[�}��ݒ�
(require 'color-theme)
(color-theme-initialize)
(color-theme-molokai)


;; �J�[�\���s�̒P��R�s�[
(defun kill-ring-save-current-word ()
"Save current word to kill ring as if killed, but don't kill it."
(interactive)
(kill-new (current-word)))
(global-set-key "\C-xw" 'kill-ring-save-current-word)


;; �w�肵���P����n�C���C�g
;; M-#�Ń|�C���g�ʒu�̒P����n�C���C�g�AM-$�Ńn�C���C�g����
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
;; isearch-forward-with-heading��"isfh"
;; C-s C-w�ŃJ�[�\���ʒu�̒P����ꊇ��������
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
(global-set-key (kbd "C-M-@") 'er/contract-region) ;; ���[�W���������߂�

;; transient-mark-mode�� nil�ł͓��삵�܂���̂Œ���
(transient-mark-mode t)

;; 5�s�P�ʂł̈ړ�
(global-set-key "\M-n"(kbd "C-u 5 C-n"))
(global-set-key "\M-p"(kbd "C-u 5 C-p"))


;; Emacs��Ctlr+a��Ctrl+e�ɂ����Ɗ��􂵂Ă��炤
;; http://d.hatena.ne.jp/orangeclover/20110301/1298910542
(require 'sequential-command-config)
(sequential-command-setup-keys)


(require 'undohist)

;;;; tree-undo
(when (require 'undo-tree nil t)
  (global-undo-tree-mode))

;; ��ʂ��R��������
;; http://d.hatena.ne.jp/yascentur/20110621/1308585547

(defun split-window-three-n (num_wins)
  (interactive "p")
  (split-window-horizontally)
  (split-window-vertically)
  )

(global-set-key "\C-x@" '(lambda ()
                           (interactive)
                           (split-window-three-n 3)))

;; ���ԑ}��
(defun my-get-date-gen (form) (insert (format-time-string form)))
(defun my-get-date() (interactive) (my-get-date-gen "%Y/%m/%d"))

;; C-cC-d�Ŏ��ԑ}���ł���悤�ɂ���
(global-set-key "\C-c\C-d" 'my-get-date)



;; �I�������������O��ɕ�����}������i����֐��j
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



;; �֐��ꗗ
(global-set-key "\C-c\C-f" 'anything-imenu)

;;; ���݂̊֐��������[�h���C���ɕ\��
(which-function-mode 1)

;; yasnippet
(add-to-list 'load-path
             (expand-file-name "~/.emacs.d/elpa/yasnippet-0.8.0"))
(require 'yasnippet)
 
(setq yas-snippet-dirs
      '("~/.emacs.d/elpa/yasnippet-0.8.0/snippets"
        ))
(yas-global-mode 1)

;; �����X�j�y�b�g��}��
(define-key yas-minor-mode-map (kbd "C-x y i") 'yas-insert-snippet)
;; �V�K�X�j�y�b�g���쐬����o�b�t�@��p�ӂ���
(define-key yas-minor-mode-map (kbd "C-x y n") 'yas-new-snippet)
;; �����X�j�y�b�g�̉{���A�ҏW
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


;; �N�����ɍő剻
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

;; quickrun�̕��������΍�
(add-hook 'java-mode-hook (lambda ()
                            (setq quickrun-option-cmdopt "-J-Dfile.encoding=UTF-8")))


;; ���ʂ̎����}��
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

;; java�̎����⊮
(add-to-list 'load-path "~/.emacs.d/elisp/auto-java-complete")
(require 'ajc-java-complete-config)
(add-hook 'java-mode-hook 'ajc-java-complete-mode)
(add-hook 'find-file-hook 'ajc-4-jsp-find-file-hook)

;; �����⊮ON/OFF
(global-set-key "\C-c\C-a" 'auto-complete-mode)

;; sql-mode��auto complete���I���ɂ���
(add-to-list 'ac-modes 'sql-mode)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; C-h��backspace�Ƃ��ė��p����
(global-set-key "\C-h" 'delete-backward-char)

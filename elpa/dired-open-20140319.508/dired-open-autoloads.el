;;; dired-open-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "dired-open" "dired-open.el" (21689 735 0 0))
;;; Generated autoloads from dired-open.el

(autoload 'dired-open-file "dired-open" "\
Try `dired-open-functions' to open the thing under point.

That can be either file or any other line of dired listing.

If no function succeeded, run `dired-find-file' normally.

With \\[universal-argument], run `dired-find-file' normally.

\(fn &optional ARG)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; dired-open-autoloads.el ends here

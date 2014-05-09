(when linux-p
;; HTMLファイルは表示しない。
(setq mime-setup-enable-inline-html nil)

;; HTMLメールはw3mで
(require 'mime-setup)
(when (locate-library "mime-w3m")
  (require 'w3m-ems)
  (require 'w3m-load)
  (require 'mime-w3m)
  (setq mime-w3m-safe-url-regexp nil)
  )
)

;; ;; summary-mode ですべての header を一旦除去
;; (setq mime-view-ignored-field-list '("^.*"))
;; ;; ;; 表示するヘッダ。
;; (setq wl-message-visible-field-list
;; (append mime-view-visible-field-list
;; '("^Subject:" "^From:" "^To:" "^Cc:"
;; "^X-Mailer:" "^X-Newsreader:" "^User-Agent:"
;; "^X-Face:" "^X-Mail-Count:" "^X-ML-COUNT:"
;; )))

;; ;; 隠すメールヘッダを指定。
;; (setq wl-message-ignored-field-list
;; (append mime-view-ignored-field-list
;; '(".*Received:" ".*Path:" ".*Id:" "^References:"
;; "^Replied:" "^Errors-To:"
;; "^Lines:" "^Sender:" ".*Host:" "^Xref:"
;; "^Content-Type:" "^Content-Transfer-Encoding:"
;; "^Precedence:"
;; "^Status:" "^X-VM-.*:"
;; "^X-Info:" "^X-PGP" "^X-Face-Version:"
;; "^X-UIDL:" "^X-Dispatcher:"
;; "^MIME-Version:" "^X-ML" "^Message-I.:"
;; "^Delivered-To:" "^Mailing-List:"
;; "^ML-Name:" "^Reply-To:" "Date:"
;; "^X-Loop" "^X-List-Help:"
;; "^X-Trace:" "^X-Complaints-To:"
;; "^Received-SPF:" "^Message-ID:"
;; "^MIME-Version:" "^Content-Transfer-Encoding:"
;; "^Authentication-Results:"
;; "^X-Priority:" "^X-MSMail-Priority:"
;; "^X-Mailer:" "^X-MimeOLE:"

;; ;; add for gmail
;; "^Received-SPF:" "Delivered-To:" "Authentication-Results:"
;; "DKIM-Signature:" "DomainKey-Signature:"
;; "MIME-Version:" "Message-ID:"
;; "List-Unsubscribe:"
;; )))

(when linux-p
;;;------------------------------------------
;;; その他の設定
;; 大きなメッセージを分割して送信しない(デフォルトはtで分割する)
(setq mime-edit-split-message nil)

;; 起動時からオフラインにする
;; (setq wl-plugged nil)
;; サマリモードで日時を英語表示
;; (setq wl-summary-weekday-name-lang 'en)
;; メールを書くときは見出し画面を残して、フル画面にする
(setq wl-draft-reply-buffer-style 'keep)
;; 送信済みIMAPフォルダは送信と同時に既読にする
(setq wl-fcc-force-as-read t)
;; 最初からスレッドを開いておかない
;;(setq wl-thread-insert-opened nil)
;; スレッドを分割するしきい値(デフォルト：30)
(setq wl-summary-max-thread-depth 30)
;; 警告無しに開けるメールサイズの最大値(デフォルト：30K)
(setq elmo-message-fetch-threshold 500000)
;; プリフェッチ時に確認を求めるメールサイズの最大値(デフォルト：30K)
(setq wl-prefetch-threshold 500000)

;;;------------------------------------------
;; (setq wl-dispose-folder-alist
;; (cons '("^%inbox" . remove) wl-dispose-folder-alist))
;;;------------------------------------------
;;; from,to のデコード指定。
(mime-set-field-decoder
'From nil 'eword-decode-and-unfold-unstructured-field-body)
(mime-set-field-decoder
'To nil 'eword-decode-and-unfold-unstructured-field-body)
;;;---------------------------------------------------
;; ファイル名が日本語の添付ファイルをデコードする
(eval-after-load "mime"
'(defadvice mime-entity-filename
(after eword-decode-for-broken-MUA activate)
"Decode eworded file name for *BROKEN* MUA."
(when (stringp ad-return-value)
(setq ad-return-value (eword-decode-string ad-return-value t)))))

;; ファイル名が日本語の添付ファイルをエンコードする [semi-gnus-ja: 6046]
(eval-after-load "std11"
'(defadvice std11-wrap-as-quoted-string (before encode-string activate)
"Encode a string."
(require 'eword-encode)
(ad-set-arg 0 (or (eword-encode-string (ad-get-arg 0)) "" )) ))

;; 添付ファイルがある場合は「@」を表示
;; (setq elmo-msgdb-extra-fields
;; (cons "content-type" elmo-msgdb-extra-fields))
;; (setq wl-summary-line-format-spec-alist
;; (append wl-summary-line-format-spec-alist
;; '((?@ (wl-summary-line-attached)))))
(setq wl-summary-line-format "%n%T%P%1@%M/%D(%W)%h:%m %t%[%17(%c %f%) %] %s")

;; サマリの横幅は制限なし
(setq wl-suumary-width nil)

(setq ssl-program-arguments '("s_client" "-quiet" "-host" host "-port" service))
)
(deftheme telega-ascii)

(custom-theme-set-variables
 'telega-ascii
 '(telega-symbol-telegram
   (propertize "◀" 'face '(italic telega-blue))
   ;; "*String used as telegram logo."
   )
 '(telega-symbol-mode
   "<"
   ;; "*String used for telega modes."
   )
 '(telega-symbol-eliding
   "..."
   ;; "*String used for eliding long string in formats.
   ;; Nice looking middle dots can be done by setting
   ;; `telega-symbol-eliding' to `(make-string 3 #x00b7)'
   ;; or set it to \"\\u2026\" or \"\\u22ef\" to use unicode char for
   ;; ellipsis."
   )
 '(telega-symbol-eye
   "<+>"
   ;; "String to use as eye symbol."
   )
 '(telega-symbol-pin
   "'"
   ;; "*String to use as pin symbol."
   )
 '(telega-symbol-custom-order
   (cons "<" ">")
   ;; "Symbols used to emphasize custom order for the chat.
   ;; car is used if custom order is less then real chat's order.
   ;; cdr is used if custom order is greater then real chat's order."
   )
 '(telega-symbol-lock
   "%"
   ;; "*String to use as lock symbol."
   )
 '(telega-symbol-flames
   "!"
   ;; "*Symbol used in self-destruct photos/videos."
   )
 '(telega-symbol-attachment
   "@"  ;\U0001F4CE
   ;; "*String to use as attachment symbol.
   ;; \"📄\" is also good candidate."
   )
 '(telega-symbol-photo
   "@*"     ;\U0001F4F7
   ;; "*String to use as photo symbol."
   )
 '(telega-symbol-audio
   "@~"     ;\U0001F3B6
   ;; "*String to use as audio symbol."
   )
 '(telega-symbol-video
   "@@"     ;\U0001F4F9
   ;; "*String to use as video symbol."
   )
 '(telega-symbol-game
   "#"      ;\U0001F3AE
   ;; "*String to use as video game symbol."
   )
 '(telega-symbol-pending
   "-> ..."   ;\u231B
   ;; "Symbol to use for pending outgoing messages."
   )
 '(telega-symbol-checkmark
   (propertize "," 'face '(:foreground "magenta")) ;\u2713
   ;; "Symbol for single check mark."
   )
 '(telega-symbol-heavy-checkmark
   (propertize "." 'face '(:foreground "green")) ;\u2714
   ;; "Symbol for double check mark."
   )
 '(telega-symbol-no-checkmark
   " "
   ;; "Status symbol for non-outgoing messages.
   ;; Used for alignment with outgoing messages."
   )
 '(telega-symbol-checkbox-on
   "[×]"
   ;; "Symbol for checked button."
   )
 '(telega-symbol-checkbox-off
   "[ ]"
   ;; "Symbol for unchecked button."
   )
 '(telega-symbol-radiobox-on
   "(*)"
   ;; "Symbol for checked radio button."
   )
 '(telega-symbol-radiobox-off
   "( )"
   ;; "Symbol for unchecked radio button."
   )
 '(telega-symbol-button-close
   "[×]"
   ;; "Symbol to use for close buttons."
   )
 '(telega-symbol-button-left
   "["
   ;; "Symbol to use for left part of the button."
   )
 '(telega-symbol-button-right
   "]"
   ;; "Symbol to use for right part of the button."
   )
 '(telega-symbol-failed
   (propertize "!" 'face 'error)
   ;; "Mark messages that have sending state failed."
   )
 '(telega-symbol-horizontal-bar
   "-"
   ;; "Symbol used to draw horizontal bars/delimiters.
   ;; Horizontal delimiters are used to draw chat filter/sorter bar in rootbuf."
   )
 '(telega-symbol-vertical-bar
   "|"
   ;; "Symbol used to form vertical lines."
   )
 '(telega-symbol-vbar-left
   "|"
   ;; "Symbol for vertical bar aligned to the left."
   )
 '(telega-symbol-underline-bar
   "_"
   ;; "Symbol used to draw underline bar.
   ;; \"\uFF3F\" is also good candidate for underline bar."
   )
 '(telega-symbol-underline-bar-partial
   "."
   ;; "Symbol used to draw underline bar in chatbuf with partial history."
   )
 '(telega-symbol-unread
   "●"
   ;; "Symbol used for chats marked as unread.
   ;; Good candidates also are 🄌 or ⬤."
   )
 '(telega-symbol-verified
   (propertize "+" 'face 'telega-blue)
   ;; "Symbol used to emphasize verified users/groups."
   )
 '(telega-symbol-star
   (propertize "*" 'face 'error)
   ;; "Symbol used to emphasize starred chats."
   )
 '(telega-symbol-lightning
   "!*"
   ;; "Symbol used inside [INSTANT VIEW] buttons."
   )
 '(telega-symbol-boost
   "!!"
   ;; "Symbol used to mean \"boost\"."
   )
 '(telega-symbol-location
   "@."
   ;; "Symbol used for location."
   )
 '(telega-symbol-phone
   "📞"
   ;; "Symbol used as phone."
   )
 '(telega-symbol-square
   "■"
   ;; "Symbol used for large squares."
   )
 '(telega-symbol-member
   "E"
   ;; "Symbol used for chat members and non-contact users."
   )
 '(telega-symbol-contact
   "@#"
   ;; "Symbol used for contacts."
   )
 '(telega-symbol-play
   "▶"
   ;; "Symbol used for playing."
   )
 '(telega-symbol-pause
   ";"
   ;; "Symbol used for pause."
   )
 '(telega-symbol-invoice
   ""
   ;; "Symbol used in invoice messages."
   )
 '(telega-symbol-credit-card
   ""
   ;; "Symbol used for inline keyboard buttons of type \"buy\"."
   )
 '(telega-symbol-poll
   "{...}"
   ;; "Symbol used in poll messages."
   )
 '(telega-symbol-poll-options
   '(radiobox-off radiobox-on)
   ;; "Symbols used to display poll options with single choice.
   ;; First - for non-selected option.
   ;; Second - for selected option."
   )
 '(telega-symbol-poll-multiple-options
   '(checkbox-off checkbox-on)
   ;; "Symbols used to display poll options with multiple answers allowed.
   ;; First - for non-selected option.
   ;; Second - for selected option."
   )
 '(telega-symbol-quiz-options
   (list (compose-chars ?○ ?✓)
         "○"
         (compose-chars ?○ ?✗))
   ;; "Symbols used to display quiz options.
   ;; First - for correct option.
   ;; Second - for non-selected incorrect option.
   ;; Third - for selected incorrect option."
   )
 '(telega-symbol-topic-brackets

   (cons (compose-chars ?\⟦ ?\s)
         (compose-chars ?\⟧ ?\s))
   ;; "Symbols used to emphasize topics."
   )
 '(telega-symbol-attach-brackets
   (cons "⟬" "⟭")
   ;; "Symbols used to emphasize attachment in chat buffer input."
   )
 '(telega-symbol-expand-details
   "▼"
   ;; "Symbol used to display expandable sections.
   ;; Such as `textEntityTypeExpandableBlockQuote' or `pageBlockDetails'
   ;; webpage block."
   )
 '(telega-symbol-collapse-details
   "▲"
   ;; "Symbol used to display expandable sections.
   ;; Such as `textEntityTypeExpandableBlockQuote' or `pageBlockDetails'
   ;; webpage block."
   )
 '(telega-symbol-webpage-details
   (cons "▼" "▲")
   ;; "Symbols used to display `pageBlockDetails' webpage block."
   )
 '(telega-symbol-online-status
   (propertize "*" 'face 'success)
   ;; "Symbol used to display user's online status in root buffer.
   ;; If nil, then user's online status is not displayed."
   )
 '(telega-symbol-blocked
   (propertize "⛒" 'face 'error)
   ;; "Symbol used to mark blacklisted users."
   )
 '(telega-symbol-inline
   "⮍"
   ;; "Symbol used to mark attachments with inline result from bot."
   )
 '(telega-symbol-alarm
   "⏲️"
   ;; "*Symbol used for scheduled messages."
   )
 '(telega-symbol-dice-list
   (list "🎲" "⚀" "⚁" "⚂" "⚃" "⚄" "⚅")
   ;; "List of dices to show for \"messageDice\"."
   )
 '(telega-symbol-folder
   "📁"
   ;; "Symbol used for Telegram folders."
   )
 '(telega-symbol-multiple-folders
   "🗂️"
   ;; "Symbol to use to denote multiple folders."
   )
 '(telega-symbol-outline-close
   "▸"
   ;; "Symbol to be used for closed outlines."
   )
 '(telega-symbol-outline-open
   "▾"
   ;; "Symbol to be used for open outlines."
   )
 '(telega-symbol-linked
   "⭾"
   ;; "Symbol used for linked chats button in modeline."
   )
 '(telega-symbol-keyboard
   "🖮"
   ;; "Symbol used to display reply markup keyboard."
   )
 '(telega-symbol-reply
   "-'"
   ;; "Symbol used to for replies."
   )
 '(telega-symbol-reply-quote
   "-\""
   ;; "Symbol used to for replies with quotes."
   )
 '(telega-symbol-forward
   (compose-chars ?🗩 ?🠒)
   ;; "Symbol used to display forwarding."
   )
 '(telega-symbol-circle
   "◯"
   ;; "Circle to create nice looking text avatars."
   )
 '(telega-symbol-bulp
   "💡"
   ;; "Bulp symbol to be used for quiz polls with explanation."
   )
 '(telega-symbol-chat-list
   "📑"
   ;; "Symbol to use to emphasize main or archive custom filter buttons."
   )
 '(telega-symbol-bell
   "🔔"
   ;; "Symbol to use to draw a bell (notification)."
   )
 '(telega-symbol-download-progress
   '(?= . ?>)
   ;; "Symbols to use when drawing progress bar for dowloading files.
   ;; By default `(?= . ?>)' is used resulting in =====> progress bar."
   )
 '(telega-symbol-upload-progress
   '(?+ . ?>)
   ;; "Symbols to use when drawing progress bar for uploading files.
   ;; By default `(?+ . ?>)' is used resulting in +++++> progress bar."
   )
 '(telega-symbol-video-chat-active
   "🗣️"
   ;; "Symbol to use for non-empty video chats."
   )
 '(telega-symbol-video-chat-passive
   "🗧"
   ;; "Symbol to use for empty video chats."
   )
 '(telega-symbol-favorite
   "🔖"
   ;; "Symbol to use for favorite messages, bookmarks."
   )
 '(telega-symbol-leave-comment
   "💬"
   ;; "Symbol used to display symbol before \"Leave Comment\" button."
   )
 '(telega-symbol-timer-clock
   "⏲"
   ;; "Symbol used as timer clock in live location context."
   )
 '(telega-symbol-distance
   "📏"
   ;; "Symbol used to display distance in location context."
   )
 '(telega-symbol-copyright
   "©"
   ;; "Symbol used to emphasize protected content."
   )
 '(telega-symbol-reaction
   "💟"
   ;; "Symbol used to display reactions."
   )
 '(telega-symbol-premium
   (propertize "*" 'face 'telega-blue)
   ;; "Symbol used to emphasize premium Telegram users."
   )
 '(telega-symbol-telegram-star

   (propertize "★" 'face '(:foreground "goldenrod"))
   ;; "Symbol used to display Telegram Star."
   )
 '(telega-symbol-forum
   "🗊"
   ;; "Symbol used for chats as forum."
   )
 '(telega-symbol-topic
   "#"
   ;; "Symbol used in topic's context."
   )
 '(telega-symbol-sender-and-text-delim
   ">"
   ;; "Symbol to delimit message sender title from text.
   ;; Used in one line message inserter."
   )
 '(telega-symbol-story
   "◌"
   ;; "Symbol used in stories context."
   )
 '(telega-symbol-story-reply
   (compose-chars ?◌ ?⮪)
   ;; "Symbol used in replies to stories."
   )
 '(telega-symbol-right-arrow
   "->"
   ;; "Symbol used as right arrow."
   )
 '(telega-symbol-codeblock
   "</>"
   ;; "Symbol to be used in code blocks."
   )
 '(telega-symbol-saved-messages-tag-end
   "▶"
   ;; "End for the tag in the Saved Messages."
   )
 '(telega-symbol-typing
   ".."
   ;; "Symbol to be used as prefix for typing actions."
   )

 '(telega-symbol-mark

   (propertize " " 'face 'custom-invalid)
   ;; "*Symbol used to denote marked messages/chats."
   )

 '(telega-symbol-mention-mark

   (propertize "@" 'face 'telega-mention-count)
   ;; "*Symbol used to mark messages which contains unread mention."
   )
 '(telega-symbol-reaction-mark
   telega-symbol-reaction
   ;; "*Symbol used to mark messages which contains unread reaction."
   )
 )

(provide-theme 'telega-ascii)

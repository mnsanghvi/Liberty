deferred class GET_TEXT[E_]

feature {ANY}
   translation (message: STRING): E_ is
         -- Translation of `message' into current locale
         --
         -- The translation is looked up in the default text domain.
         --
         -- See also: `set_message_locale'
      require
         message.is_ascii
         is_text_domain_set
         is_message_locale_set
         is_text_domain_set_up(text_domain)
      deferred
      ensure
         Result.is_equal(domain_translation(text_domain, message))
      end

feature {FILTER_GET_TEXT}
   domain_translation (domain_name, message: STRING): like translation is
         -- Translation of `message' into current locale
         --
         -- The translation is looked up in the text domain `domain_name'.
         --
         -- See also: `set_message_locale'
      require
         message.is_ascii
         is_message_locale_set
         is_text_domain_set_up(domain_name)
      deferred
      end

   register_domain (domain_name: STRING) is
         -- Used by a FILTER_GET_TEXT to let the filtered GET_TEXT
         -- know that it will use the text domain `domain_name'.
      deferred
      end

feature {ANY}
   message_locale: STRING is
         -- The locale (roughly, the language) in which the program
         -- should output messages.
      deferred
      end

   is_message_locale_set: BOOLEAN is
      deferred
      ensure
         Result = (message_locale /= Void)
      end

feature {ANY}
   text_domain: STRING is
         -- The default text domain (namespace in which messages are
         -- looked up)
      deferred
      end

   is_text_domain_set: BOOLEAN is
         -- Was a default text domain set?
      deferred
      ensure
         Result implies not text_domain.is_empty
      end

   is_text_domain_set_up (domain_name: STRING): BOOLEAN is
         -- Is `Current' ready to translate messages from domaine
         -- `domain_name'? The precise way of setting up a domain
         -- varies between implementations but will typically involve
         -- loading a message catalog.
      require
         domain_name /= Void
      deferred
      end

feature {ANY}
   text_domain_code_set (domain_name: like text_domain): STRING is
         -- The encoding of the `Result' of `xxx_translation'
      require
         domain_name /= Void
      deferred
      end

end -- class GET_TEXT
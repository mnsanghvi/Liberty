deferred class EDC_RECORD

feature {ANY}
   delete is
      require
         added: session /= Void
      deferred
      ensure
         removed: session = Void and then session_data = Void
      end

   session: EDC_SESSION

feature {EDC_SESSION}
   session_data: EDC_SESSION_DATA

   set_session_data (a_data: like session_data) is
      do
         session_data := a_data
      end

   set_session (a_session: like session) is
      require
         (a_session = Void) /= (session = Void)
      do
         session := a_session
      ensure
         session = a_session
      end

end

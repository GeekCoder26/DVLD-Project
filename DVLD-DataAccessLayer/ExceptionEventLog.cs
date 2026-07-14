using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DVLD_DataAccessLayer
{
    public class ExceptionEventLog
    {

        public static void RegiterErrorToLogRegitry(Exception ex)
        {
            string SourceName = "DVLD_PROJECT";

            if (!EventLog.SourceExists(SourceName))
            {
                EventLog.CreateEventSource(SourceName, "Application");
            }
            EventLog.WriteEntry(SourceName, ex.Message, EventLogEntryType.Error);

        }




    }
}

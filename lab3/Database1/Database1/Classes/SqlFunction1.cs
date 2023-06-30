using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.IO;
using Microsoft.SqlServer.Server;

public partial class UserDefinedFunctions
{
    [Microsoft.SqlServer.Server.SqlFunction]
    public static SqlBoolean WriteTextFile(SqlString text,
                                        SqlString path,
                                        SqlBoolean append)
    {
        // text: Contains information to be written.
        // path: The complete file path to write to.
        // append: Determines whether data is to be appended to the file.
        // if the file exists and append is false, the file is overwritten.
        // If the file exists and append is true, the data is appended to the file.
        // Otherwise, a new file is created.
        try
        {
            // Check for null input.
            if (!text.IsNull &&
                !path.IsNull &&
                !append.IsNull)
            {
                // Get the directory information for the specified path.
                var dir = Path.GetDirectoryName(path.Value);
                // Determine whether the specified path refers to an existing directory.
                if (!Directory.Exists(dir))
                    // Create all the directories in the specified path.
                    Directory.CreateDirectory(dir);
                // Initialize a new instance of the StreamWriter class
                // for the specified file on the specified path.
                // If the file exists, it can be either overwritten or appended to.
                // If the file does not exist, create a new file.
                using (var sw = new StreamWriter(path.Value, append.Value))
                {
                    // Write specified text followed by a line terminator.
                    sw.WriteLine(text);
                }
                // Return true on success.
                return SqlBoolean.True;
            }
            else
                // Return null if any input is null.
                throw new ArgumentException("Some attribute are null");
        }
        catch (Exception ex)
        {
            // Return null on error.
            throw new Exception(ex.Message);
        }
    }
}

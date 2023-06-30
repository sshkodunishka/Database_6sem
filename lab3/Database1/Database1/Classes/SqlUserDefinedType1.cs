using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.IO;
using System.Text.RegularExpressions;
using Microsoft.SqlServer.Server;

[Serializable]
[SqlUserDefinedType(Format.UserDefined,
    MaxByteSize = -1)]
public struct CustomRoute : INullable, IBinarySerialize
{
    private string _route;

    public SqlString Route
    {
        get { return new SqlString(_route); }
        set
        {
            if (value == null)
            {
                _route = string.Empty;
                return;
            }

            string str = (string)value;

            if (str.Contains("->"))
            {
                _route = str;
            }
            else
            {
                throw new ArgumentException("Route is not valid.");
            }
        }
    }

    public override string ToString()
    {
        return _route;
    }

    public bool IsNull
    {
        get { return string.IsNullOrEmpty(_route); }
    }

    public static CustomRoute Null
    {
        get
        {
            CustomRoute n = new CustomRoute();
            n._route = string.Empty;
            return n;
        }
    }

    public static CustomRoute Parse(SqlString s)
    {
        if (s.IsNull)
            return CustomRoute.Null;

        CustomRoute n = new CustomRoute();
        n.Route = s;

        return n;
    }

    public void Read(BinaryReader r)
    {
        _route = r.ReadString();
    }

    public void Write(BinaryWriter w)
    {
        w.Write(_route);
    }
}
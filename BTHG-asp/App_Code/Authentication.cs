using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public class Authentication
{
    public const int VISITOR = 0;
    public const int SECRETARY = 1;
    public const int DIRECTOR = 2;

    int privilege;

    public int Privilege
    {
        get
        {
            return privilege;
        }
        set
        {
            privilege = value;
        }
    }

    public string Username
    {
        get;
        set;
    }

    public int IDStaff
    {
        get;
        set;
    }

	public Authentication(int privilege)
	{
        this.privilege = privilege;
	}
}
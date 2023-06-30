using lab2_v2.Models;
using System.Collections.Generic;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace lab2_v2.DAL
{
    public class TourRepository
    {
        private SqlConnection con;
        private void connection()
        {
            string constr = ConfigurationManager.ConnectionStrings["TravelAgencyContext"].ToString();
            con = new SqlConnection(constr);

        }

        public bool AddTour(Tours obj)
        {
            connection();
            string query = "AddTour";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@idCountry", obj.idCountry);
            cmd.Parameters.AddWithValue("@idOperator", obj.idOperator);
            cmd.Parameters.AddWithValue("@tourName", obj.tourName);
            cmd.Parameters.AddWithValue("@descr ", obj.descr);

            con.Open();
            int i = cmd.ExecuteNonQuery();
            con.Close();
            if (i >= 1)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public bool UpdateTour(Tours obj)
        {

            connection();
            con.Open();
            string query = "UpdateTour";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@idTours", obj.idTours);
            cmd.Parameters.AddWithValue("@idCountry", obj.idCountry);
            cmd.Parameters.AddWithValue("@idOperator", obj.idOperator);
            cmd.Parameters.AddWithValue("@tourName", obj.tourName);
            cmd.Parameters.AddWithValue("@descr", obj.descr);
            int i = cmd.ExecuteNonQuery();
            con.Close();
            if (i >= 1)
            {

                return true;
            }
            else
            {
                return false;
            }
        }

        public bool DeleteTour(int Id)
        {

            connection();
            string query = "DeleteTour";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@idTours", Id);

            con.Open();
            int i = cmd.ExecuteNonQuery();
            con.Close();
            if (i >= 1)
            {
                return true;
            }
            else
            {

                return false;
            }
        }

        public List<Tours> GetAllTours()
        {
            connection();
            List<Tours> toursList = new List<Tours>();

            con.Open();
            SqlCommand cmd = new SqlCommand("Select * from Tours", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            con.Close();
            //Bind EmpModel generic list using dataRow     
            foreach (DataRow dr in dt.Rows)
            {
                toursList.Add(
                    new Tours
                    {
                        tourName = Convert.ToString(dr["tourName"]),
                        descr = Convert.ToString(dr["descr"]),
                        idCountry = Convert.ToInt32(dr["idCountry"]),
                        idOperator = Convert.ToInt32(dr["idOperator"]),
                        idTours = Convert.ToInt32(dr["idTours"]),
                    }
                    );
            }

            return toursList;
        }
    }
}